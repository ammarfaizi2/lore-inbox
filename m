Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131161AbQKNOdH>; Tue, 14 Nov 2000 09:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131155AbQKNOc6>; Tue, 14 Nov 2000 09:32:58 -0500
Received: from lsne-cable-1-p21.vtxnet.ch ([212.147.5.21]:59150 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S131039AbQKNOci>;
	Tue, 14 Nov 2000 09:32:38 -0500
Date: Tue, 14 Nov 2000 15:02:07 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001114150206.D8753@almesberger.net>
In-Reply-To: <3A0CB6FD.D4CCE09F@transmeta.com> <200011111605.RAA01615@kufel.dom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011111605.RAA01615@kufel.dom>; from kufel!ankry@green.mif.pg.gda.pl on Sat, Nov 11, 2000 at 05:05:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, the checks after line 153 in linux/arch/i386/boot/tools/build.c
reflect all those limitations.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
