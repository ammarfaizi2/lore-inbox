Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSJ2T2D>; Tue, 29 Oct 2002 14:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSJ2T17>; Tue, 29 Oct 2002 14:27:59 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:27664 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S262190AbSJ2T0x>; Tue, 29 Oct 2002 14:26:53 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove the conv option of fat (1/3)
References: <Pine.LNX.4.44.0210290949120.6190-100000@home.transmeta.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 30 Oct 2002 04:33:09 +0900
In-Reply-To: <Pine.LNX.4.44.0210290949120.6190-100000@home.transmeta.com>
Message-ID: <87d6pt82h6.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> This patch was damaged in interesting ways, in particular the number of 
> lines in the patch description was wrong, causing the patch program to get 
> very confused.
> 
> That implies that you're using some kind of post-processing tool to remove
> lines from the diff, without fixing up the diff numeric output. Correct?  
> If so, your tools are broken.
> 
> I ended up hand-editing the diff to make it apply, please don't make me do 
> it again.

Whoops, sorry. The tools was correct. The 8bit char in that mail was
encoded by mailer. Probably, because `=' in my patch was broken by it,
patch command was confused.

So I made the mailer a setting which doesn't encode iso-8859-1 for the
moment.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
