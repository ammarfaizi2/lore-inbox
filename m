Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVIKRU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVIKRU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 13:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVIKRU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 13:20:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:27786 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751107AbVIKRU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 13:20:27 -0400
Date: Sun, 11 Sep 2005 10:15:08 -0700
From: Greg KH <gregkh@suse.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: Valdis.Kletnieks@vt.edu, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050911171508.GA12106@suse.de>
References: <20050909214542.GA29200@kroah.com> <Pine.LNX.4.62.0509101742300.28852@qynat.qvtvafvgr.pbz> <200509110713.j8B7DsNR021781@turing-police.cc.vt.edu> <Pine.LNX.4.62.0509110016110.29141@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509110016110.29141@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 12:20:06AM -0700, David Lang wrote:
> On Sun, 11 Sep 2005 Valdis.Kletnieks@vt.edu wrote:
> 
> >On Sat, 10 Sep 2005 23:08:36 PDT, David Lang said:
> >
> >>remember that the distros don't package every kernel, they skip several
> >>between releases and it's not going to be until they go to try them that
> >>all the kinks will get worked out.
> >
> >I'll bite - what distros are shipping a kernel 2.6.10 or later and still
> >using devfs?
> >
> I'll admit I don't keep track of the distros and what kernels and features 
> they are useing. I think I've heard people mention gentoo, but I 
> haven't verified this.

Haha, no, Gentoo does not use devfs for it's 2.6 kernels at all.  I
should know, I'm a Gentoo developer too :)

thanks,

greg k-h
