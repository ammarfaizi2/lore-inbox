Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132379AbRAVSI5>; Mon, 22 Jan 2001 13:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133010AbRAVSIs>; Mon, 22 Jan 2001 13:08:48 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:62726 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S132379AbRAVSIk>;
	Mon, 22 Jan 2001 13:08:40 -0500
Date: Mon, 22 Jan 2001 19:08:07 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Keith Owens <kaos@ocs.com.au>
Cc: David Luyer <david_luyer@pacific.net.au>, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: "Pass module parameters" to built-in drivers
Message-ID: <20010122190807.R18286@almesberger.net>
In-Reply-To: <20010122165638.E4979@almesberger.net> <5766.980181036@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5766.980181036@ocs3.ocs-net>; from kaos@ocs.com.au on Tue, Jan 23, 2001 at 03:30:36AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> It is part of my total Makefile rewrite for 2.5.

Oh, I see. Too bad.

> A clean implementation of module parameters mapping to setup code requires
> the mapping of a source file to the module it is linked into.

I was afraid that this would be a problem (and hoping that you've found
some miracle solution ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
