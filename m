Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbULECmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbULECmv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 21:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbULECmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 21:42:51 -0500
Received: from hera.kernel.org ([63.209.29.2]:6549 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261230AbULECmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 21:42:43 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: kernel CVS is malfunctioning
Date: Sun, 5 Dec 2004 02:42:38 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cotsiu$iuf$1@terminus.zytor.com>
References: <20041204032723.GX32635@dualathlon.random> <m3is7iezcu.fsf@athlon.kvaalen.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1102214558 19408 127.0.0.1 (5 Dec 2004 02:42:38 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 5 Dec 2004 02:42:38 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m3is7iezcu.fsf@athlon.kvaalen.no>
By author:    =?iso-8859-1?q?H=E5vard_Kv=E5len?= <havardk@kvaalen.no>
In newsgroup: linux.dev.kernel
>
> Andrea Arcangeli <andrea@suse.de> writes:
> 
> > The kernel CVS seems screwed. cvsps -x --bkcvs tells there are 2
> > checkins.
> 
> This has already been reported to linux-kernel:
> 
> | From: Larry McVoy <lm@bitmover.com>
> | To: linux-kernel@vger.kernel.org
> | Subject: [BK2CVS] locking problems on kernel.org
> | Date:  Fri, 3 Dec 2004 06:53:07 -0800
> | Message-Id: <200412031453.iB3Er70l003000@work.bitmover.com>
> |
> | The last few days the locking mechanism on kernel.org has been broken.
> | The result is that the CVS export tree isn't getting updated.  I've mailed
> | the admins and gotten no response, does anyone know who manages that
> | machine?
> 

I sent back a reply saying "we don't see anything wrong with the
locking mechanism, details please?"

Now, the *UPLOAD* mechanism was broken for a while.  That has been
fixed.

	-hpa
