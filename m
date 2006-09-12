Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWILVfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWILVfc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWILVfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:35:32 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:25513 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751431AbWILVfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:35:31 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: R: Linux kernel source archive vulnerable
Date: Tue, 12 Sep 2006 21:35:21 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ee796o$vue$1@taverner.cs.berkeley.edu>
References: <20060907182304.GA10686@danisch.de> <8E63F0FB-DDD3-41D4-AFA7-88E66D0E9C8D@mac.com> <ee72if$sng$1@taverner.cs.berkeley.edu> <Pine.LNX.4.61.0609121619470.19976@chaos.analogic.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1158096921 32718 128.32.168.222 (12 Sep 2006 21:35:21 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Tue, 12 Sep 2006 21:35:21 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os \(Dick Johnson\) wrote:
>On Tue, 12 Sep 2006, David Wagner wrote:
>> Just because it is a bug in tar doesn't mean that Linux developers have
>> to create their tarfile in a way that tickles the bug.  Two wrongs don't
>> make a right.
>
>It's not a tar bug, [...]

You misunderstand my point.  I don't care whether it is a tar bug or not.
I'm not claiming it is a tar bug.  I'm saying that people on those threads
claimed that this is a tar bug and used that as an excuse to do nothing
about the problem of world-writeable files in the Linux tar archive.
I'm saying that's a lousy excuse.  What I'm saying is that, even if we
accept that it is a tar bug, that's not a good excuse for doing nothing
about the problem.  Of course, if it is not a tar bug, then that makes
it an even weaker excuse.
