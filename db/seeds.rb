admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)


title_prefixes = ['7 ways to', 'The ultimate guide to', 'How to', 'The best way to', 'The secret to', 'The art of', 'Mastering']
title_suffixes = ['travel free', 'boost your productivity', 'improve your health', 'learn a new skill', 'save money', 'achieve your goals', 'live your best life']


10.times do |i|
  title = "#{title_prefixes.sample} #{title_suffixes.sample}"

  content = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
    "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo."
  ].sample(5).join(" ")

  image_url = "https://source.unsplash.com/600x400/?blog,post,image,#{i}"

  Post.create!(
    title: title,
    content: content,
    image: image_url,
    user: admin
  )
end
