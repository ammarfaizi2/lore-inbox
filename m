Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135222AbRD3SSi>; Mon, 30 Apr 2001 14:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRD3SSY>; Mon, 30 Apr 2001 14:18:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:9032 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135222AbRD3SQ5>; Mon, 30 Apr 2001 14:16:57 -0400
Date: Mon, 30 Apr 2001 20:15:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 locks up on SMP
Message-ID: <20010430201547.G19620@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0104281402090.2487-100000@age.cs.columbia.edu> <E14uHtt-0008KA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14uHtt-0008KA-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 30, 2001 at 06:55:54PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 06:55:54PM +0100, Alan Cox wrote:
> A couple. It looks lik the VM changes may have upset something (based on
> reports saying it began at that point). Can you see if 2.2.19pre stuff is
> stable ?

I also have reports but related to the network driver updates. So I
suggest to try again with 2.2.19 but with the drivers/net/* of 2.2.18.

Andrea
