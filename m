Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTLUObL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 09:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTLUObK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 09:31:10 -0500
Received: from mail.shareable.org ([81.29.64.88]:48263 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261719AbTLUObG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 09:31:06 -0500
Date: Sun, 21 Dec 2003 14:30:43 +0000
From: Jamie Lokier <jamie@shareable.org>
To: James Morris <jmorris@redhat.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
Message-ID: <20031221143043.GJ3438@mail.shareable.org>
References: <20031221105333.GC3438@mail.shareable.org> <Xine.LNX.4.44.0312210833030.3044-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0312210833030.3044-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> This approach would turn Linux into proprietary software.

You're saying a Linux kernel with _more_ capabilities that I and
everyone else outside the USA can use, learn from, modify and
distribute freely is proprietary, whereas denying me access to those
capabilities is more free?

I guess it is more free for people living within the patented economic
zones, and less free for people outside them.

To put it into perspective: I'd love for Mandrake or SuSE or Polish or
Red Flag Linux to come with a full suite of modem, DSL and wireless
drivers, and support for VFAT and Longhorn filesystems.

There's two ways to go about it:

    1. First way is we develop a common Linux kernel which everyone in
       the USA may use, even if it contains things like encryption
       which are not so legal in some other parts of the world.

       This is obviously how it's done right now.

       Mandrake, SuSE, Polish, Red Flag and everyone else outside the
       USA must apply the Big Linux Patch to build kernels which
       support all the extra devices and filesystems.

    2. Second way is to include all those extra wireless drivers
       etc. in the common kernel, but disable them somehow for USA
       users.  Note that the USA users have not lost anything.

       Distributing the code in disabled form _may_ not be legal in
       practice, I simply do not know, so maybe the second way is not
       permissible.  But if there is a chance it is permissible, don't
       you think it should be explored?

-- Jamie
