Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbQLKPbp>; Mon, 11 Dec 2000 10:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbQLKPbf>; Mon, 11 Dec 2000 10:31:35 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:60682 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129627AbQLKPbQ>;
	Mon, 11 Dec 2000 10:31:16 -0500
Date: Mon, 11 Dec 2000 16:00:24 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Jeff Chua <jchua@fedex.com>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] initrd vs. BLKFLSBUF
Message-ID: <20001211160024.G573@almesberger.net>
In-Reply-To: <20001120042151.A599@almesberger.net> <000f01c06368$9122cee0$aa5812bc@corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01c06368$9122cee0$aa5812bc@corp.fedex.com>; from jchua@fedex.com on Mon, Dec 11, 2000 at 07:50:12PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
> I'm posting this again hoping that it'll get incorporated into the kernel.

It's already in Alan's tree (e.g. patch-2.4.0test11-ac1.bz2) and should
find its way from there into Linus' tree soon (i.e. probably by test12).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
