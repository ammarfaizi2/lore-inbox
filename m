Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132274AbRAQTux>; Wed, 17 Jan 2001 14:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130999AbRAQTum>; Wed, 17 Jan 2001 14:50:42 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:58129 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130107AbRAQTua>;
	Wed, 17 Jan 2001 14:50:30 -0500
Date: Wed, 17 Jan 2001 20:50:07 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010117205007.D4979@almesberger.net>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95195@ATL_MS1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95195@ATL_MS1>; from Venkateshr@ami.com on Tue, Jan 16, 2001 at 12:39:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Ramamurthy wrote:
> 	[Venkatesh Ramamurthy]  The LILO boot loader and the LILO command
> line utility should be changed for this. There are some issues when we have

Grr, I was just waiting for this ...

See sections 2.6 and 3.5 of
ftp://icaftp.epfl.ch/pub/people/almesber/booting/bootinglinux-0.ps.gz
for my views on such things.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
