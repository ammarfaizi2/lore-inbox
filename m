Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131094AbQKIUnO>; Thu, 9 Nov 2000 15:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131120AbQKIUnD>; Thu, 9 Nov 2000 15:43:03 -0500
Received: from 041imtd118.chartermi.net ([24.247.41.118]:28656 "EHLO
	oof.netnation.com") by vger.kernel.org with ESMTP
	id <S131094AbQKIUmu>; Thu, 9 Nov 2000 15:42:50 -0500
Date: Thu, 9 Nov 2000 15:42:44 -0500
From: Simon Kirby <sim@stormix.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Pentium 4 and 2.4/2.5
Message-ID: <20001109154243.A25865@stormix.com>
In-Reply-To: <Pine.LNX.3.96.1001108132530.8587A-100000@kanga.kvack.org> <E13taG6-0000JH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13taG6-0000JH-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 08, 2000 at 06:47:40PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 06:47:40PM +0000, Alan Cox wrote:

> Ok. Issue settled. So 'rep nop' is safe. Ok that can get into the spinlocks
> for 2.2.18

Just curious... What does "rep nop" actually accomplish, anyway?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
