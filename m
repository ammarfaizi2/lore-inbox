Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129035AbRBILhH>; Fri, 9 Feb 2001 06:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130482AbRBILg6>; Fri, 9 Feb 2001 06:36:58 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:3595 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129035AbRBILgs>;
	Fri, 9 Feb 2001 06:36:48 -0500
Date: Fri, 9 Feb 2001 12:36:40 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
Message-ID: <20010209123640.B17129@almesberger.net>
In-Reply-To: <3A83B6B0.8261F3CF@idb.hist.no> <3A83C4A1.5090903@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A83C4A1.5090903@megapathdsl.net>; from miles@megapathdsl.net on Fri, Feb 09, 2001 at 02:21:21AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> Since, as Christophe mentions, the boot messages would
> still be accessible via CTRL-ALT-F2, I don't see what 
> the problem is with at least making this an option.

Except if some initialization hangs your machine so badly that it even
won't respond to Ctrl-Alt-F2.

This could of course be cured by a little window where the last three or
four printk lines are shown ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
