Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTBJGNn>; Mon, 10 Feb 2003 01:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbTBJGNn>; Mon, 10 Feb 2003 01:13:43 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:786 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S263215AbTBJGNm>; Mon, 10 Feb 2003 01:13:42 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Date: 10 Feb 2003 05:59:19 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <b27f3n$bbj$1@abraham.cs.berkeley.edu>
References: <20030206151820.A11019@infradead.org> <Pine.LNX.3.96.1030207205056.31221A-100000@dixie> <20030209200626.A7704@infradead.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1044856759 11635 128.32.153.211 (10 Feb 2003 05:59:19 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 10 Feb 2003 05:59:19 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig  wrote:
>[...] given that selinux is the only module actually using it [...]

No, it's not.  I keep you telling you LSM is not just about SELinux,
but I'm happy to say it again, if necessary.

>you don't get tru security by adding hooks.

Of course not.  Noone is saying that the LSM hooks alone give security;
rather, they enable you to install a module that gives security.

>security needs a careful design

You keep saying this.  People keep telling you that LSM does have a
careful design.  I suspect you mean that you don't like the design we
chose, for whatever reason -- but that's a different sort of beast,
isn't it?

If you have constructive suggestions, I'm listening.
