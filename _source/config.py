from yozuch.route import route

# Base settings
TITLE = "You're doing it wrong!"
URL = 'http://localhost:8000'
DESCRIPTION = 'Rants about whatever...'
AUTHOR = 'Ethan Estrada'

THEME_NAME = 'foundation'
THEME_CONFIG = {
    'disqus_shortname': None,     # example
    'google_analytics_id': None,  # UA-xxxxxxxx-x
    'github_profile_url': 'https://github.com/eestrada',   # https://github.com/example
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
