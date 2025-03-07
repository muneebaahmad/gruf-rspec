# Copyright (c) 2018-present, BigCommerce Pty. Ltd. All rights reserved
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
# persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
# Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
module Gruf
  module Rspec
    ##
    # Factory for building metadata in an incoming controller request
    #
    class MetadataFactory
      ##
      # @param [Hash] options
      #
      def initialize(options = {})
        @options = options || {}
      end

      ##
      # @param [Hash] metadata
      # @return [Hash]
      #
      def build(metadata = {})
        metadata ||= {}
        authentication_hydrator.hydrate(metadata)
      end

      private

      ##
      # @return [Gruf::Rspec::AuthenticationHydrator::Base]
      #
      def authentication_hydrator
        unless @authentication_hydrator
          auth_type = @options.fetch(:authentication_type, :basic).to_sym
          auth_type = :base unless Gruf::Rspec.authentication_hydrators.key?(auth_type)
          @authentication_hydrator = Gruf::Rspec.authentication_hydrators[auth_type].new(@options)
        end
        @authentication_hydrator
      end
    end
  end
end
