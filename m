Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261797AbREPGTd>; Wed, 16 May 2001 02:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261798AbREPGTX>; Wed, 16 May 2001 02:19:23 -0400
Received: from www.sinfopragma.it ([213.26.181.2]:61704 "EHLO
	sinfo-www-01.sinfopragma.it") by vger.kernel.org with ESMTP
	id <S261797AbREPGTJ>; Wed, 16 May 2001 02:19:09 -0400
Date: Wed, 16 May 2001 08:18:25 +0200 (W. Europe Daylight Time)
From: Lorenzo Marcantonio <lorenzo.marcantonio@sinfopragma.it>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Lorenzo Marcantonio <lomarcan@tin.it>, <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape Corruption - 2nd round experiment result
In-Reply-To: <Pine.LNX.4.05.10105151815010.18650-100000@callisto.of.borg>
Message-ID: <Pine.WNT.4.31.0105160817290.306-100000@pc209.sinfopragma.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Geert Uytterhoeven wrote:

> I never saw an offset different from the block size, though.
>
> Assuming you did have 32-byte errors, you had 7 errors for 1.3 GB.
>
> I have approx. 6 errors for 256 MB. But I have only 128 MB RAM.

Next test: boot with mem=32M .... (shall I get 0 errors?... naaahh)

				-- Lorenzo Marcantonio


