from yozuch.route import route

# Base settings
TITLE = 'Blog title'
URL = 'http://localhost:8000'
DESCRIPTION = 'Blog description'
AUTHOR = 'Name Surname'

THEME_NAME = 'foundation'
THEME_CONFIG = {
    'disqus_shortname': None,     # example
    'google_analytics_id': None,  # UA-xxxxxxxx-x
    'github_profile_url': None,   # https://github.com/example
    'twitter_profile_url': None,  # https://twitter.com/akrylysov
    'navigation': [
        ('Blog', 'blog-index'),
        ('Tags', 'tags-index'),
        ('Archive', 'archive-index'),
        ('About', '/about/'),
        ('RSS', 'atom-feed'),
    ],
    'logo_url': '/',
}

# Routes
ROUTES = (
    route('/', 'blog-index'),
    route('/blog/{date:%Y}/{date:%m}/{date:%d}/{slug}/', 'posts'),
    route('/tags/', 'tags-index'),
    route('/tag/{slug}/', 'tags'),
    route('/archive/', 'archive-index'),
    route('/{slug}/', 'documents'),
    route('/atom.xml', 'atom-feed'),
    route('/{filename}', 'assets'),
)
