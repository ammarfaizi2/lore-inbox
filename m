Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbUJZNan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUJZNan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 09:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbUJZNan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 09:30:43 -0400
Received: from main.gmane.org ([80.91.229.2]:14242 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262266AbUJZNaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 09:30:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: The naming wars continue...
Date: Tue, 26 Oct 2004 15:09:55 +0200
Message-ID: <MPG.1be8533f25663a40989703@news.gmane.org>
References: <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org> <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org> <4179F81A.4010601@yahoo.com.au> <417D7089.3070208@tmr.com> <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-159-143.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> 
> On Mon, 25 Oct 2004, Bill Davidsen wrote:
> > 
> > I do agree that the pre and rc names gave a strong hint that (-pre) new 
> > features would be considered or (-rc) it's worth doing more serious 
> > testing.
> 
> Well, I actually do try to _explain_ in the kernel mailing list 
> annoucements what it going on.
> 
> One of the reasons I don't like "-rcX" vs "-preX" is that they are so 
> meaningless. In contrast, when I actually do the write-up on a patch, I 
> tend to explain what I expect to have changed, and if I feel we're getting 
> ready for a release, I'll say something like
> 
> 	..
> 
> 	Ok,
> 	 trying to make ready for the real 2.6.9 in a week or so, so please give
> 	this a beating, and if you have pending patches, please hold on to them
> 	for a bit longer, until after the 2.6.9 release. It would be good to have
> 	a 2.6.9 that doesn't need a dot-release immediately ;)
> 
> 	....
> 
> which is a hell of a lot more descriptive, in my opinion.

Yeah but try fitting that in the extraversion. Maybe we should 
use -hopstt(hold on patches, stress-test this) for this kind of 
stuff, and -beo (bring 'em on) for the "early" -rcX ... :)

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

