Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281533AbRKPUOF>; Fri, 16 Nov 2001 15:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281532AbRKPUNz>; Fri, 16 Nov 2001 15:13:55 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2432 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S281530AbRKPUNn>;
	Fri, 16 Nov 2001 15:13:43 -0500
Date: Fri, 16 Nov 2001 10:19:30 +0000
From: Pavel Machek <pavel@suse.cz>
To: Brian <hiryuu@envisiongames.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: File server FS?
Message-ID: <20011116101930.D37@toy.ucw.cz>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net>; from hiryuu@envisiongames.net on Tue, Nov 13, 2001 at 05:03:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We are about to build a fairly large (720GB) file server using Linux.  No 
> sane person would actually want to watch this thing fsck, but I've seen 
> mixed reports about the functionality of the journaled FSes.

fsck should take hour and a half with 4K blocksize. And I *would* like
to see it fsck ;-))))
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

