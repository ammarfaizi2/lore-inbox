Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbTIDOXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbTIDOWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:22:54 -0400
Received: from mail2-216.ewetel.de ([212.6.122.116]:58519 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S265031AbTIDOVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:21:20 -0400
Date: Thu, 4 Sep 2003 16:21:14 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: David Schwartz <davids@webmaster.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Driver Model
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEOCGDAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.44.0309041545100.989-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, David Schwartz wrote:

> So are you arguing that I can distribute a derived work from the Linux
> kernel and attach a 'you may not use this unless you pay me $100' clause
> and it would be enforceable?

Well, the GPL does not allow you to impose retrictions on copying and
redistribution, so you cannot disallow others redistributing your work
without your usage clause attached, and it would be legal for them to
do that under the GPL.

Your restriction could only effect the part of the kernel you
actually modified, because that would be the only part you have
copyright on. How are you going to prove people used that part? They
have the right to modify the copy, unrestricted, so they could've
taken your piece of the code out before using the kernel.

> If you are right, you've discovered a serious fundamental flaw in the 
> GPL. I can distribute code under the GPL and prohibit anyone from using 
> derived works, hence effectively removing their freedom to modify.

No, I don't see how you have influence over derived works. Nothing in
the GPL allows you to bind redistributors to your usage clause, since
copying and redistribution is covered by the GPL.

> Then you have no right to usage. The preamble contradicts this, but I
> doubt it's binding.

Well, under German law, if I have the right to legally obtain something,
I automatically have the right to usage. Law only comes into play again if
I redistribute it or use it in public in some illegal way.

Under German law, you need a real contract in place for usage
restrictions to be effective or you need to make certain kinds of
usage technically impossible (because if you don't, courts will say
you did not even attempt to protect your interests). And no, MS-type 
"open this bag and you're bound to our license" is not a legal contract 
over here. Violation of the usage restriction would then fall under 
contract law, not copyright law.

I don't see how GPL'ed code can have technical restrictions since I
can easily compile and change it and I don't have to sign a contract to 
get it since the license grants unrestricted redistribution right.

This may all be different in the US, of course.

> This is only about works that you distribute or publish. We're talking
> about using modules.

Well, somebody must have distributed the module, and if that act was
illegal because of a GPL violation, I don't know whether you have any
right to usage anyway.

> Copyright enforcement schemes can also restrict usage. Access cards for
> satellite TV are purely usage restriction devices.

These come with a contract here in Germany, and once you have a contract,
you can of course, within some limits, put usage restrictions in it as
much as you like. You just have to make sure you only give the card to
someone who has indeed signed the contract.

-- 
Ciao,
Pascal

