Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135323AbRD3S3i>; Mon, 30 Apr 2001 14:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135497AbRD3S3a>; Mon, 30 Apr 2001 14:29:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29000 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135323AbRD3S3W>; Mon, 30 Apr 2001 14:29:22 -0400
Date: Mon, 30 Apr 2001 20:28:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 locks up on SMP
Message-ID: <20010430202824.I19620@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0104281402090.2487-100000@age.cs.columbia.edu> <E14uHtt-0008KA-00@the-village.bc.nu> <20010430201547.G19620@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010430201547.G19620@athlon.random>; from andrea@suse.de on Mon, Apr 30, 2001 at 08:15:47PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 08:15:47PM +0200, Andrea Arcangeli wrote:
> suggest to try again with 2.2.19 but with the drivers/net/* of 2.2.18.

even better try vanilla 2.2.19aa2 and if it crashes too, try 2.2.19aa2
plus the drivers/net/* of 2.2.18.

Andrea
