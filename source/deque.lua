class('Deque').extends()

function Deque:init()
  self.head = 0
  self.tail = -1
  self.data = {}
end

-- add value to tail
function Deque:push(value)
  self.tail += 1
  self.data[self.tail] = value
end

-- remove and return value from tail
function Deque:pop()
  if (self:empty()) then
    return nil
  end

  local result = self.data[self.tail]
  self.data[self.tail] = nil
  self.tail -= 1
  return result
end

-- remove and return value from head
function Deque:shift()
  if (self:empty()) then
    return nil
  end

  local result = self.data[self.head]

  self.data[self.head] = nil
  self.head += 1
  return result
end

-- add value to head
function Deque:unshift(value)
  self.head -= 1
  self.data[self.head] = value
end

-- return value from head
function Deque:peek()
  if (self:empty()) then
    return nil
  end

  return self.data[self.head]
end

-- return value form tail
function Deque:peekBack()
  if (self:empty()) then
    return nil
  end

  return self.data[self.tail]
end

-- return true if Deque has no items
function Deque:empty()
  return self.head > self.tail
end