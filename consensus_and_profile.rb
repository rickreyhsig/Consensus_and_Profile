#!/usr/bin/env ruby

# Obtain file contents
file_content = ARGV[0]

# Place file content in file variable
file = File.open(file_content, "r")

# Read file contents and place it inside variable
dna_strings = file.read
dna_array = dna_strings.split(/\r?\n/)
file.close

# Hash for storing {id_string => GC-content}
gcHash = Hash.new

# Hash for storing {id_string => dna_string}
dnaHash = Hash.new

tmp_str = ""
cur_id = ""

# Build dnaHash
dna_array.each do |element|

  if element.include? '>'
    element.gsub! '>', ''
    cur_id = element
    dnaHash[cur_id] = ""
    tmp_str = ""
  else
    tmp_str += element
  end
  dnaHash[cur_id] = tmp_str
end

# Get values without dna string (Eliminate >Rosalind_X)
h = dnaHash.values

# Default matrix size filled with zeros
profileMatrix = Array.new(4,0) {Array.new(h[0].length,0)}
i_cnt = 0
j_cnt = 0

h.each do |i|
  j_cnt = 0
  i.each_char do |j|
    profileMatrix[0][j_cnt] += 1 if j == 'A'
    profileMatrix[1][j_cnt] += 1 if j == 'C'
    profileMatrix[2][j_cnt] += 1 if j == 'G'
    profileMatrix[3][j_cnt] += 1 if j == 'T'
    j_cnt += 1
  end
  i_cnt += 1
end

profileTranspose = Array.new()
profileTranspose = profileMatrix.transpose

consensus = Array.new()
profileTranspose.each do |e|
    consensus << 'A' if e.index(e.max) == 0
    consensus << 'C' if e.index(e.max) == 1
    consensus << 'G' if e.index(e.max) == 2
    consensus << 'T' if e.index(e.max) == 3
end

puts consensus.join

i_cnt = 0
baseArr = ['A','C','G','T']
profileMatrix.each do |e|
    a = e.inspect.gsub '[', ''
    a = a.gsub ']', ''
    a = a.gsub ',', ''
    puts baseArr[i_cnt] + ': ' + a
    i_cnt += 1
end
