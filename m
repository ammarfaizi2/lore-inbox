Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVIKLCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVIKLCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 07:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVIKLCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 07:02:25 -0400
Received: from THUNK.ORG ([69.25.196.29]:15815 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932467AbVIKLCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 07:02:24 -0400
Date: Sun, 11 Sep 2005 07:02:14 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Lang <david.lang@digitalinsight.com>
Cc: Valdis.Kletnieks@vt.edu, Greg KH <gregkh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050911110214.GA16408@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Lang <david.lang@digitalinsight.com>, Valdis.Kletnieks@vt.edu,
	Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050909214542.GA29200@kroah.com> <Pine.LNX.4.62.0509101742300.28852@qynat.qvtvafvgr.pbz> <200509110713.j8B7DsNR021781@turing-police.cc.vt.edu> <Pine.LNX.4.62.0509110016110.29141@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509110016110.29141@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 12:20:06AM -0700, David Lang wrote:
> >I'll bite - what distros are shipping a kernel 2.6.10 or later and still
> >using devfs?
> >
> I'll admit I don't keep track of the distros and what kernels and features 
> they are useing. I think I've heard people mention gentoo, but I 
> haven't verified this.

Nope, not Gentoo --- Greg KH fixed gentoo a while ago.  :-)

> however with the thousands of linux distros out there I'd lay odds that 
> _someone_ is doing it ;-)

Yes, but if none of the major distributions are doing it, then past a
certain point we should just pull the trigger and be done with it.
C'mon, devfs's impending removal has been announced for a year.  It's
not like anyone can complain that they didn't get enough warning.....

							- Ted
