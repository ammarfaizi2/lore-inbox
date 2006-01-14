Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWANX4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWANX4q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 18:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWANX4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 18:56:46 -0500
Received: from main.gmane.org ([80.91.229.2]:61587 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751318AbWANX4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 18:56:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [GIT PATCH] SPI patches for 2.6.15
Date: Sun, 15 Jan 2006 08:56:32 +0900
Message-ID: <dqc33h$5bv$1@sea.gmane.org>
References: <20060114004403.GA21106@kroah.com> <dq9vqv$6o7$1@sea.gmane.org> <20060114112013.GA11446@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060115)
In-Reply-To: <20060114112013.GA11446@vrfy.org>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers wrote:
> On Sat, Jan 14, 2006 at 01:48:30PM +0900, Kalin KOZHUHAROV wrote:
>> Greg KH wrote:
>>> Here are a few patches for 2.6.15 that add a SPI driver subsystem to the
>>> kernel tree.
> 
>>> Please pull from:
>>> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/spi-2.6.git/
> 
>> May be just a browser accessible URL for Documentation/spi/spi-summary or at
>> least a definition of SPI in the header of the mail.
>>
>> git is just too complex for me at htemoment (haven't found the time to learn it)
> 
> If the git web interface is "too complex" for you, then you may not
> need to know what SPI is too. :)
> 
>   http://www.kernel.org/git/?p=linux/kernel/git/gregkh/spi-2.6.git;a=commitdiff;h=8ae12a0d85987dc138f8c944cb78a92bf466cea0


Thank you for the link, it turns I wasn't right about the meaning...
What I had in mind is to include say the beginning two lines of
Documentation/spi/spi-summary in the first mail (the usual procedure for
patch-00 as I can see):

The "Serial Peripheral Interface" (SPI) is a synchronous four wire serial
link used to connect microcontrollers to sensors, memory, and peripherals.

I always give the -ck patches as an example: even if you don't know what are
they about, what does -ck mean and so on, just reading the first one or two
sentences is enough to decide: to read on or to go next thread.

By seeing this most people will be able to decide whether there are
interested or not and those who are interested should spend the time to find
the patch (learn to use git if needed), etc.

I know we are not talking Web design here, but "Don't let me think" is an
excellent book that I just finished and it teaches exactly what the title
says is a good design, not only web.

And I know Greg posts and comments and everything is very professional, I
know basically who he is and how important he is. /me is mostly reading here
and trying to be helpful, eventually asking for help/explanation of issues I
run into.

Thank you again for the time.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

