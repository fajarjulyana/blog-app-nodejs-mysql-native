const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const bcrypt = require('bcrypt');
const Post = require('./models/Post');
const User = require('./models/User');
const sequelize = require('./config/database');
const mysql = require('mysql2');
const app = express();

// Buat koneksi ke database MySQL
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'blogdb'
});

// Hubungkan ke database
connection.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err.stack);
        return;
    }
    console.log('Connected to the database as id ' + connection.threadId);
});

app.use(bodyParser.urlencoded({ extended: false }));
app.set('view engine', 'ejs');
app.use(express.static('public'));

// Konfigurasi sesi
app.use(session({
    secret: 'fajarjulyana',
    resave: false,
    saveUninitialized: false,
}));

// Middleware untuk melindungi rute admin
function requireLogin(req, res, next) {
    if (!req.session.userId) {
        return res.redirect('/login');
    }
    next();
}

// Rute untuk homepage
app.get('/', (req, res) => {
    res.redirect('/posts');
});

// Rute untuk menampilkan semua post
app.get('/posts', async (req, res) => {
    const posts = await Post.findAll({ order: [['createdAt', 'DESC']] });
    res.render('posts', { posts });
});
// Rute untuk menampilkan detail post
app.get('/posts/:id', async (req, res) => {
    const postId = req.params.id;
    const post = await Post.findByPk(postId);
    if (post) {
        res.render('postDetail', { post });
    } else {
        res.status(404).send('Post not found');
    }
});
// Rute untuk membuat post baru (admin saja)
app.get('/admin/posts/create', requireLogin, (req, res) => {
    res.render('admin/admin-create-post');
});

app.post('/posts/create', requireLogin, async (req, res) => {
    const { title, content, thumbnail } = req.body;
    await Post.create({ title, content, thumbnail });
    res.redirect('/admin/posts');
});

// Rute untuk menghapus post (admin saja)
app.post('/posts/delete/:id', requireLogin, async (req, res) => {
    const postId = req.params.id;
    await Post.destroy({ where: { id: postId } });
    res.redirect('/admin/posts');
});
// Rute untuk menampilkan form edit post (admin saja)
app.get('/posts/edit/:id', requireLogin, async (req, res) => {
    const postId = req.params.id;
    const post = await Post.findByPk(postId);
    if (post) {
        res.render('edit-post', { post });
    } else {
        res.status(404).send('Post not found');
    }
});

// Rute untuk menangani update post (admin saja)
app.post('/posts/edit/:id', requireLogin, async (req, res) => {
    const postId = req.params.id;
    const { title, content, thumbnail } = req.body;
    await Post.update({ title, content, thumbnail }, { where: { id: postId } });
    res.redirect('/admin/posts');
});

// Rute untuk menampilkan post berdasarkan ID
app.get('/posts/:id', (req, res) => {
    const postId = req.params.id;
    connection.query('SELECT * FROM posts WHERE id = ?', [postId], (err, results) => {
        if (err) {
            console.error('Error fetching post:', err.stack);
            res.status(500).send('Error fetching post');
            return;
        }
        if (results.length > 0) {
            const post = results[0];
            res.render('postDetail', { post });
        } else {
            res.status(404).send('Post not found');
        }
    });
});

// Rute untuk admin menampilkan semua post
app.get('/admin/posts', requireLogin, async (req, res) => {
    const posts = await Post.findAll({ order: [['createdAt', 'DESC']] });
    res.render('admin/admin-posts', { posts });
});

// Rute untuk registrasi admin (hanya digunakan sekali)
app.get('/register', (req, res) => {
    res.render('register');
});

app.post('/register', async (req, res) => {
    const { username, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    await User.create({ username, password: hashedPassword });
    res.redirect('/login');
});

// Rute untuk login admin
app.get('/login', (req, res) => {
    res.render('login');
});

app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    const user = await User.findOne({ where: { username } });
    if (user && await bcrypt.compare(password, user.password)) {
        req.session.userId = user.id;
        res.redirect('/admin/posts');
    } else {
        res.status(401).send('Invalid username or password');
    }
});

// Rute untuk logout admin
app.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/login');
});

// Inisialisasi database dan server
sequelize.sync().then(() => console.log("Database Connected"));

app.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
});
