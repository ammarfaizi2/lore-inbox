Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVDNMmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVDNMmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 08:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVDNMmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 08:42:38 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:14602 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261490AbVDNMmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 08:42:18 -0400
Message-ID: <425E6627.9080405@aitel.hist.no>
Date: Thu, 14 Apr 2005 14:46:31 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: John M Collins <jmc@xisl.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Exploit in 2.6 kernels
References: <1113298455.16274.72.camel@caveman.xisl.com> <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com> <20050412210857.GT11199@shell0.pdx.osdl.net> <1113341579.3105.63.camel@caveman.xisl.com> <425CEAC2.1050306@aitel.hist.no> <20050413125921.GN17865@csclub.uwaterloo.ca>
In-Reply-To: <20050413125921.GN17865@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:

>On Wed, Apr 13, 2005 at 11:47:46AM +0200, Helge Hafting wrote:
>  
>
>>You're not.  Complain to nvidia - using both email and snailmail.
>>If everybody with such problems did that, chances are they see
>>the light someday. Oh, and complain to the guy handing out
>>nvidia cards like confetti, state your preference for some other
>>card.  Perhaps that is easier to achieve.
>>    
>>
>
>What card would you recomend to people?
>  
>
If all else fail - an *old* card.  This wasn't a problem before,
therefore it doesn't have to be now.  Unless you want to run
very new software that won't perform on those older cards.
Todays faster cpus may help though.

Look to http://dri.freedesktop.org/wiki/ for information about
which cards have open drivers and how well they work.
Some cards have specs available, others are reverse-engineered
to the extent that a driver have been written.

>  
>
>>Whats wrong with tainting?  It is just a message, telling you that
>>the kernel is unsupported.  In this case because you're running a
>>closed-source module.  The tainting message itself does not do
>>anything bad.  There is a way - which is to write an open nvidia
>>driver.  To do that, you'll need to get the specs out of nvidia or
>>figure it out by reverse-engineering some other nvidia driver. Either
>>approach is hard, so people generally find it cheaper to just buy
>>a supported card.
>>    
>>
>
>It is becoming harder and harder to find supported cards it seems.
>Finding a card with decent 2D drivers for X can still be done, but 3D is
>just not really an option it seems.  Even 2D seems to be a problem on
>many cards if you don't use a binary only driver.
>  
>
I have the impression that 2D is fine with ATI cards, even those
that doesn't have open 3D drivers.  And even a really old low-end
card performs fine for 2D work.  Even the unaccelerated
framebuffer drivers seems to have enough performance
for 2D in most cases. The cpu is fast these days. :-)

Helge Hafting

