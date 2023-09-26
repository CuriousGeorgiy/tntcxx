box.cfg{listen = '3301,unix/:./tnt.sock', net_msg_max=10000, readahead=163200, log='tarantool.txt'}

if box.space.T then box.space.T:drop() end
s = box.schema.space.create('T')
s:format{{name='id',type='integer'},{name='a',type='string'},{name='b',type='number'}}
s:create_index('primary')
s:replace{1, 'asd', 1.123}

function remote_replace(arg1, arg2, arg3)
    return box.space.T:replace({arg1, arg2, arg3})
end

function remote_select()
    return box.space.T:select()
end

function remote_uint()
    return 666
end

function remote_multi()
    return 'Hello', 1, 6.66
end

function remote_nil()
    return nil
end

function remote_map()
    return {key = 777}
end

function bench_func(...)
    return {...}
end

function get_rps()
    return box.stat.net().REQUESTS.rps
end

box.schema.user.grant('guest', 'read,write', 'space', 'T', nil, {if_not_exists=true})
box.schema.user.grant('guest', 'execute', 'universe', nil, {if_not_exists=true})

if box.space.S then box.space.S:drop() end
secret = box.schema.space.create('S')
secret:format{{name='id',type='integer'},{name='secret',type='string'}}
secret:create_index('primary')
secret:replace{0, "There's a secret place I like to go", 3.14}

box.schema.user.create('megauser', {password = 'megapassword'})
box.schema.user.grant('megauser', 'read,write', 'space', 'S', nil, {if_not_exists=true})
