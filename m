Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264752AbUEYKn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264752AbUEYKn2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 06:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbUEYKn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 06:43:28 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3456 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264752AbUEYKnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 06:43:25 -0400
Date: Tue, 25 May 2004 11:49:11 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405251049.i4PAnBGD000155@81-2-122-30.bradfords.org.uk>
To: Jon Portnoy <portnoy@tellink.net>, Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org, rock-user@rocklinux.org
In-Reply-To: <Pine.LNX.4.58.0405241409460.5161@cerberus.oppresses.us>
References: <409BB334.7080305@pobox.com>
 <200405121412.00068.rob@landley.net>
 <200405190849.i4J8nqfb000280@81-2-122-30.bradfords.org.uk>
 <200405192059.47056.rob@landley.net>
 <Pine.LNX.4.58.0405241409460.5161@cerberus.oppresses.us>
Subject: Re: Distributions vs kernel development
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Quote from Jon Portnoy <portnoy@tellink.net>:
> On Wed, 19 May 2004, Rob Landley wrote:
> 
> > 
> > It's not really a distro.  It's an enormous HOWTO.  (Then again, so's Gentoo, 
> > but gentoo does claim to be a distro, which is where I get disappointed...)
> > 
> 
> No less a distribution than, say, Debian. You just type 'emerge' rather 
> than 'apt-get' and get source tarballs rather than binary packages.

I think the "It's not really a distro" comment was in reference to Linux
>From Scratch.

[snip]

> > You keep saying that installing from source is better, but it seems to be from 
> > "gee, wouldn't it be nice if" land rather than due to actual experience.  You 
> > _can_ build and install an SRPM into a Red Hat system.  It's too much of a 
> > pain to be worth it to me, but it's been an option for years and years.
> > 
> 
> The advantage, in my view, of compiling from source consistently is that 
> you (a) eliminate any potential bugs from the build system being 
> drastically different from the target system and (b) have the flexibility 
> of being able to fine-tune dependencies and build time configuration. 

When I was talking about users compiling from source rather than using
distribution's pre-built binaries, I didn't really have in mind users
downloading a pre-written script that compiles a binary on their own machine.

In my opinion, there are two main ways to run a Linux-based system - either
follow a particular distribution, using their binaries, or source releases, or
work independently of any distribution, and do your own thing, obtaining the
source code for the software you want to use direct from it's ftp site, or
whatever method of distribution the authors use.

Of course, it's a long process to build a system completely from source.
In practice, many users might decide to use a distribution to install the
basic components of their system, such as GCC, glibc, and various system
libraries, and then build everything else manually.  This is what I mean
by not 'following' a distribution, but simply using it as a base for the
user to do their own thing.

Now, there is the issue of support.

In my opinion, in essence, there are two ways of offering support, (regardless
of whether it's free of charge or not, and whether it's provided by users,
via mailing lists, or by an organisation such as a distribution, or
independent company).

Firstly, it is possible to learn many of the common problems that can be
encountered with any particular distribution's pre-compiled binaries, or
binaries compiled on the user's machine from a fixed script.

Secondly, it is possible to become generically knowledgable about
computers, and to solve problems in a generic way, without specific
prior knowledge of a particular system.

In my opinion, the first option is the most widespread and the most encouraged
simply because it is much easier than the second option, and appears to work
most of the time.

I admit that if the user's problem is actually a common one, the first option
may be the fastest way to solve the immediate problem.

However, in my opinion, this whole approach only appears to work at all,
because it effectively limits many, (if not most), users to using their
computers in a fraction of the number of ways possible.

Or, to put it another way, users are effectively being forced to choose
less efficient configurations, just so that they can get support.

See my previous posts in this thread for more discussion of this.

John.
