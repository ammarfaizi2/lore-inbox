Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279131AbRJZUBr>; Fri, 26 Oct 2001 16:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279132AbRJZUBh>; Fri, 26 Oct 2001 16:01:37 -0400
Received: from lego.zianet.com ([204.134.124.54]:65030 "EHLO lego.zianet.com")
	by vger.kernel.org with ESMTP id <S279131AbRJZUB2>;
	Fri, 26 Oct 2001 16:01:28 -0400
Message-ID: <3BD9BF74.4080400@zianet.com>
Date: Fri, 26 Oct 2001 13:54:28 -0600
From: Steven Spence <kwijibo@zianet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011022
X-Accept-Language: en-us
MIME-Version: 1.0
To: Sean Swallow <sean@swallow.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3Com PCI 3c905C Tornado with later kernels
In-Reply-To: <Pine.LNX.4.40.0110261142110.1175-100000@lsd.nurk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe it has somethin to do with RH scripts.  I just upgraded to 7.2 
and I got
the same crap.  I have the 3c982.  It didn't seem to affect much besides 
not loading
my eth0 correctly, but I just fixed that with ifconfig.

Steven

Sean Swallow wrote:

List,

I am having a problem with a 3c905C and later kernels (2.4.9, 2.4.12 and
2.4.13).  When I try to use my 3c905C with these kernels I get this error
message:

Cannot open netlink socket: Address family not supported by protocol

Kernel 2.4.7 works fine with this nic tho. I also tried this on another
machine with the same results.

Any suggestions?

thank you,



