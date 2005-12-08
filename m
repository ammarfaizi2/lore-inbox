Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbVLHJ0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVLHJ0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 04:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVLHJ0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 04:26:21 -0500
Received: from main.gmane.org ([80.91.229.2]:56259 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750944AbVLHJ0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 04:26:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dirk Steuwer <dirk@steuwer.de>
Subject: Re: Linux Hardware Quality Labs (was: Linux in a binary world... a doomsday scenario)
Date: Thu, 8 Dec 2005 09:23:58 +0000 (UTC)
Message-ID: <loom.20051208T101830-768@post.gmane.org>
References: <6DAD0850-4943-416E-9E7B-095C6B412DD0@oxley.org> <4397E427.2070702@laposte.net> <Pine.LNX.4.58.0512080044350.28203@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.61.178.52 (Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.7.12) Gecko/20050919 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov <vlobanov <at> speakeasy.net> writes:

> 
> On Thu, 8 Dec 2005, Nicolas Mailhot wrote:
> 
> > Felix Oxley wrote:
> > A good exhaustive online centralised hardware database, blessed and
> > maintained by kernel people, will have influence with or without a logo.
> 
> I don't think this is quite right.
> 
> The beauty of having a simple and easily-recognizable logo plastered on
> a website or product box or what have you is exactly that -- simplicity.
> That's a good thing, because it means that the person looking to
> purchase some bit of hardware can merely look for that one sign, and
> it'll be "guaranteed" to work.
> 
> Simplicity is a very good thing, in this case -- the easier it is for a
> consumer to check/notice/comprehend something, the more likely they are
> to use it and put value into that process. This leads to greater
> mindshare for that logo. And besides, there are some cases where an
> online database does not help you much: for example, if you find
> yourself shopping in a brick-and-mortar store.
> 
> An online database is definitely a very useful thing to have, for those
> who know to look for it, and who can look at it. But aside from that, a
> simple logo is what the vast majority of people wishing to purchase
> hardware would benefit from the most.
> 

Sorry for posting this in the other thread, so heres my list again, (i'm pretty
much in favour of felix' scenario):

- get all open operating system folks to join
- have an approval organisation, that everyone is happy with
- lets call it "free driver" support
- create apropriate Logos for each operating system i.e. "Penguin-Logo" 
with "free driver since kernel-a.b.c.d" or "BSD-Daemon-Logo" with "free driver
since a.b"
- the hardware version numer (usb-device id, pci-id)? will be held in a
database. 
If in doubt people can look it up there. In case future kernels will
drop support, it can be marked there as well. 
A yearly logo is too much
confusion, since hardware support for open drivers stays pretty long in 
the kernel. (Imagine you license in december - you only got a month...)
Maybe educate people that support for kernel 2.6.x.y series means a 
penguin logo on blue ground. 
If dramatic changes to the kernel are introduced, which all
drivers affect call the kernel 2.8.x.y an educate people about a new linux 
in town and create a penguin logo on yellow ground

- hardware vendors pay someone, or provide source code themselves 
to be reviewed by apropriate kernel folks/bsd board...

- small licence fee and endless advertising possiblilities pay for 
organisation folks and hosting. 
Keeping up database records could help kernel developers:
There could be a log file attached to each device stating the 
current affairs about support in varying OSs

Felix had a good senario for financing this, it should be an independend body
providing legal/licensing and marketing support. And the kernel folks should do
the technical review.

dirk

