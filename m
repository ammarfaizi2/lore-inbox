Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVANT5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVANT5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVANT5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:57:04 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:59915 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261508AbVANT5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:57:01 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: short read from /dev/urandom
Date: Fri, 14 Jan 2005 19:55:19 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <cs9837$qt$1@abraham.cs.berkeley.edu>
References: <41E7509E.4030802@redhat.com> <cs7mup$hgo$1@abraham.cs.berkeley.edu> <a36005b50501132254155a0d5a@mail.gmail.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1105732519 861 128.32.168.222 (14 Jan 2005 19:55:19 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Fri, 14 Jan 2005 19:55:19 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper  wrote:
>On Fri, 14 Jan 2005 05:56:41 +0000 (UTC), David Wagner
><daw@taverner.cs.berkeley.edu> wrote:
>> True.  Arguably, the solution is to fix the documentation.
>
>The problem is that no-short-reads behavior has been documented for a
>long time and so programs might [become insecure]
>
>Not breaking the ABI is more important than symmetry.

Ok, I see your point.  I'm persuaded.  Thanks.
