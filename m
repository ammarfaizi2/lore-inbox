Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130482AbRBEPFu>; Mon, 5 Feb 2001 10:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133014AbRBEPFk>; Mon, 5 Feb 2001 10:05:40 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:54277 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130482AbRBEPF0>;
	Mon, 5 Feb 2001 10:05:26 -0500
Date: Mon, 5 Feb 2001 16:04:52 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.2-pre1] rootfs boot parameter
Message-ID: <20010205160452.A9464@almesberger.net>
In-Reply-To: <Pine.LNX.4.21.0102051453410.1452-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0102051453410.1452-100000@penguin.homenet>; from tigran@veritas.com on Mon, Feb 05, 2001 at 02:56:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> This patch adds "rootfs" boot parameter which selects the filesystem type
> for the root filesystem.

Could you please make this rootfstype= or fstype= or maybe
root=<device>[,<type>] or such ? Calling it "rootfs" is just asking
for trouble ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
