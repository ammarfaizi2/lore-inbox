Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbREUUNG>; Mon, 21 May 2001 16:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbREUUM4>; Mon, 21 May 2001 16:12:56 -0400
Received: from a-pr4-46.tin.it ([212.216.131.173]:36224 "EHLO
	eris.discordia.loc") by vger.kernel.org with ESMTP
	id <S261651AbREUUMp>; Mon, 21 May 2001 16:12:45 -0400
Date: Mon, 21 May 2001 22:12:23 +0200 (CEST)
From: Lorenzo Marcantonio <lomarcan@tin.it>
To: Thomas Palm <palm4711@gmx.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <19729.990474214@www36.gmx.net>
Message-ID: <Pine.LNX.4.31.0105212209480.845-100000@eris.discordia.loc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, Thomas Palm wrote:

> there ist still file-corruption. I use an ASUS A7V133 (Revision 1.05,
> including Sound + Raid). My tests:
> 1st run of "diff -r srcdir destdir" -> no differs
> 2nd run of "diff -r srcdir destdir" -> 2 files differ
> 3rd run of "diff -r srcdir destdir" -> 1 file differs
> 4th run of "diff -r srcdir destdir" -> 1 file differs
> 5th run of "diff -r srcdir destdir" -> no differs

Could you check WHERE the file differ and WHERE the data come from ?

I've got the same mobo AND some nasty DAT tape corruption problems...
(also, VERY rarely, on the CD burner). I've got all on SCSI, but if it's
the DMA troubling us...

				-- Lorenzo Marcantonio


