Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271820AbTHDPvB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271836AbTHDPvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:51:01 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:41135 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S271820AbTHDPuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:50:50 -0400
Message-ID: <3F2E80EE.30401@softhome.net>
Date: Mon, 04 Aug 2003 17:51:10 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Pollard <jesse@cats-chateau.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
References: <gq0f.8bj.9@gated-at.bofh.it> <gNpS.2YJ.9@gated-at.bofh.it> <3F2E6A86.3060402@softhome.net> <03080409560301.03650@tabby>
In-Reply-To: <03080409560301.03650@tabby>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> 
> And who said it was a workstation target? If you are going to offload TCP/IP
> in a TOE, it should be where it might be useful - large (and saturated) 
> compute servers, file servers. Not workstations. High bandwidth workstation
> requirements are rare. And large servers will require IPSec eventually 
> (personally, I think it should be required already). And if the server
> requires IPSec, then the workstation will too.
> 

   I gave example of my personal WS just as an example that not every 
one needs all features, even having capacities.

   TOE for IPsec/IPv6/iptables/routing? take a look at www.cisco.com, 
this guys are doing exactly this with IOS. And take a look then at prices.
   They are not cheap.

   Take a look at prices of SMP/AMP systems. Multi-threaded software? 
like Oracle or Sybase for example? which can utilize fully SMP/AMP 
resources.
   They are not cheap.

   If you will try to make a pice of hardware to put Linux on, you will 
simultaneously get headaches of both TOE designers/programmers and 
SMP/AMP designers/programmers.
   This is not going to simple nor cheap.

   But you are encouraged to try ;-)

 > Not workstations. High bandwidth workstation
 > requirements are rare. And large servers will require IPSec eventually

   Rare? IMHO servers are rare too. Compare number of PCs/devices and 
compare the number of servers. 1000s to 1s.
   And devices are different and for most of them ipv4 is just more than 
enough, since not of them has capacity even to handle 10MB Ethernet. I'm 
not talking about ipv4/ipsec/lsm. So servers for servers? Security for 
security?


   I wanted to make a simple point: every piece should do a few of 
things, but should do it good. [1]
   Putting OS kernel into the device makes not that much sense, if you 
can achive the same with simple 3k firmware.


[1] "The Unix Philosophy in One Lesson", 
http://www.catb.org/~esr/writings/taoup/html/ch01s07.html

P.S. Gone to offtopic. Sorry. Leaving.

