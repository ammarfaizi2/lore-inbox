Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVDYQrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVDYQrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVDYQrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:47:02 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:7942 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S262684AbVDYQmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:42:55 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: more git updates..
Date: Mon, 25 Apr 2005 16:40:43 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d4j6ib$rvl$1@abraham.cs.berkeley.edu>
References: <20050423174227.51360d63.pj@sgi.com> <20050423211326.7ed8e199.pj@sgi.com> <20050424043813.GA2422@lina.inka.de> <20050425115750.GA11233@thunk.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1114447243 28661 128.32.168.222 (25 Apr 2005 16:40:43 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Mon, 25 Apr 2005 16:40:43 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o  wrote:
>The MD5 collision smaples are for two 16 byte inputs which when run
>through the MD5 algorithm, result in the same 128-bit hash.  The SHA-1
>collision samples are for two 20 byte inputs which when run through
>the SHA algorithm create the same 160-bit hash.

There are no known SHA-1 collision samples.
(There are collision samples for MD5, and for SHA-0, but not for SHA-1.)
