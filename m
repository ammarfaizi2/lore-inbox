Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129715AbRBIM2p>; Fri, 9 Feb 2001 07:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130721AbRBIM2Z>; Fri, 9 Feb 2001 07:28:25 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:6667 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129715AbRBIM2W>;
	Fri, 9 Feb 2001 07:28:22 -0500
Date: Fri, 9 Feb 2001 13:28:17 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
Message-ID: <20010209132817.U13984@almesberger.net>
In-Reply-To: <3A83B6B0.8261F3CF@idb.hist.no> <3A83C4A1.5090903@megapathdsl.net> <20010209123640.B17129@almesberger.net> <3A83D8EE.8090500@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A83D8EE.8090500@megapathdsl.net>; from miles@megapathdsl.net on Fri, Feb 09, 2001 at 03:47:58AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> I suppose perhaps an even more useful tweak to the this
> idea would be that if the user holds down a special key
> during the start of boot, the whole prettyfication stuff
> isn't used and the VT number 1 gets all the boot messages.

Hmm, this adds a lot of steps between the first occurrence of the problem
and the first useful diagnostic message. I think telephone support people
would really hate to walk their customers through this ...

Besides, people may not have the patience or knowledge to retry, and
pursue other theories first, possibly causing more damage. Of course,
readily available diagnostics can't stop them, but they may at least make
it a bit more likely that people do the right thing.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
