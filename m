Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbSJ2Rrq>; Tue, 29 Oct 2002 12:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262391AbSJ2Rrq>; Tue, 29 Oct 2002 12:47:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49158 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262084AbSJ2Rrp> convert rfc822-to-8bit; Tue, 29 Oct 2002 12:47:45 -0500
Date: Tue, 29 Oct 2002 09:53:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove the conv option of fat (1/3)
In-Reply-To: <87fzupb2pi.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.44.0210290949120.6190-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g9THrjR27141
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Oct 2002, OGAWA Hirofumi wrote:
>
> This removes the conv option. This option does nothing, now.
> (This patch from René Scharfe)

This patch was damaged in interesting ways, in particular the number of 
lines in the patch description was wrong, causing the patch program to get 
very confused.

That implies that you're using some kind of post-processing tool to remove
lines from the diff, without fixing up the diff numeric output. Correct?  
If so, your tools are broken.

I ended up hand-editing the diff to make it apply, please don't make me do 
it again.

			Linus

