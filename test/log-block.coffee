sinon = require 'sinon'

describe 'log-block', ->
  Given -> @subject = require '../lib/log-block'

  afterEach -> console.log.restore()
  Given -> sinon.stub console, 'log'

  context 'with a list of strings with no arrays in them', ->
    When -> @subject('foo', 'bar', 'baz')
    Then -> console.log.args.should.eql [
      []
    ,
      ['   ', 'foo', 'bar', 'baz']
    ,
      []
    ]

  context 'with a single array', ->
    When -> @subject(['foo', 'bar', 'baz'])
    Then -> console.log.args.should.eql [
      []
    ,
      ['   ', 'foo', 'bar', 'baz']
    ,
      []
    ]

  context 'multiple arrays', ->
    When -> @subject(['foo', 'bar'], ['baz', 'quux'])
    Then -> console.log.args.should.eql [
      []
    ,
      ['   ', 'foo', 'bar']
    ,
      ['   ', 'baz', 'quux']
    ,
      []
    ]

  context 'a mix of strings and arrays', ->
    When -> @subject(['foo', 'bar'], 'hello', ['baz', 'quux'], 'world')
    Then -> console.log.args.should.eql [
      []
    ,
      ['   ', 'foo', 'bar']
    ,
      ['   ', 'hello']
    ,
      ['   ', 'baz', 'quux']
    ,
      ['   ', 'world']
    ,
      []
    ]

  context 'with objects in an array', ->
    When -> @subject(['foo', { bar: 'baz' }])
    Then -> console.log.args.should.eql [
      []
    ,
      ['   ', 'foo', JSON.stringify(bar: 'baz')]
    ,
      []
    ]

  context 'with objects as a plain list', ->
    When -> @subject('foo', { bar: 'baz' })
    Then -> console.log.args.should.eql [
      []
    ,
      ['   ', 'foo', JSON.stringify(bar: 'baz')]
    ,
      []
    ]
