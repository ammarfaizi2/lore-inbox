Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132125AbQLLQzp>; Tue, 12 Dec 2000 11:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132160AbQLLQz0>; Tue, 12 Dec 2000 11:55:26 -0500
Received: from finch-post-12.mail.demon.net ([194.217.242.41]:47627 "EHLO
	finch-post-12.mail.demon.net") by vger.kernel.org with ESMTP
	id <S132125AbQLLQzT>; Tue, 12 Dec 2000 11:55:19 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: [PATCH] generic_serial's block_til_ready
Date: 12 Dec 2000 16:24:48 -0000
Organization: Alfie's Internet Node
Message-ID: <915jgg$pbb$1@alfie.demon.co.uk>
In-Reply-To: <Pine.LNX.4.21.0012121643100.27903-100000@panoramix.bitwizard.nl>
X-Newsreader: NN version 6.5.0 CURRENT #119
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patrick@bitwizard.nl (Patrick van de Lageweg) writes:
> This patch renames the block_til_ready of generic serial to
> gs_block_til_ready. 
> 
> it helps when other modules have a "static block_til_ready" defined when
> used older modutils.

Do you mean older than the version specified as being required in
Documention/CHANGES?

If so, then I'm not surprised the patch has not been applied (how many
times have you sent it?).

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
