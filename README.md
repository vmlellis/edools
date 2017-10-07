# Edools
[![Build Status](https://travis-ci.org/vmlellis/edools.svg?branch=master)](https://travis-ci.org/vmlellis/edools)
[![Coverage Status](https://coveralls.io/repos/github/vmlellis/edools/badge.svg?branch=master)](https://coveralls.io/github/vmlellis/edools?branch=master)

Essa gem tem como objetivo automatizar a integração com a Rest API da Edools.

## Instalação

Adicione a linha abaixo no arquivo ``Gemfile`` da sua aplicação:

```ruby
gem 'edools', git: 'https://github.com/vmlellis/edools'
```

E então execute:

    $ bundle

Ou instale manualmente:

    $ gem install edools

## Utilização

### Primeira configuração - Criar a escola

Adicione o token (credencial) administrativa:

```ruby
Edools.settings.token = 'TOKEN_ADM'
```

O retorno será:

```ruby
{ credentials: 'SCHOOL_TOKEN', school_id: SCHOOL_ID }
```

### Carregando a escola

Para carregar a escola:

```ruby
Edools.settings.token = 'SCHOOL_TOKEN'
Edools.settings.school_id = SCHOOL_ID
school = Edools.schools.get
```

### Atualizar atributos da escola

```ruby
school.data['terms_of_use'] = 'new_terms_of_use'
school.update
```

### Criar novo curso

```ruby
school.courses.create('title')
```

### Listar cursos

```ruby
school.courses.all
```

### Criar novo produto da escola

```ruby
school.products.create('name')
```

### Listar produtos da escola

```ruby
school.products.all
```

### Criar aluno

```ruby
school.students.create('first_name', 'email@email.com', 'password')
```

### Listar todos alunos de uma escola

```ruby
school.students.all
```

### Listar todos alunos de um produto

```ruby
product = school.products.find(PRODUCT_ID)
product.students.all
```

### Parte 2

### Criar sessão

```ruby
Edools.settings.subdomain = 'SUBDOMAIN'
Edools.settings.school_id = SCHOOL_ID
session_data = Edools.sessions.create(EMAIL, PASSWORD)

Edools.settings.token = session_data['credentials']
```

### Carregar url de uma mídia

```ruby
media = Edools.media.get(MEDIA_ID)
s3_file_url = media['s3_file_url']
```

### Importar CSV

```ruby
loader = Edools.loader.csv(CSV_PATH)
loader.start
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vmlellis/edools.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
