Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130815AbRBOCXy>; Wed, 14 Feb 2001 21:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131587AbRBOCXf>; Wed, 14 Feb 2001 21:23:35 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:42484 "EHLO
	tytlal.z.streaker.org") by vger.kernel.org with ESMTP
	id <S130815AbRBOCXX>; Wed, 14 Feb 2001 21:23:23 -0500
Date: Wed, 14 Feb 2001 18:20:06 -0800
From: Chip Salzenberg <chip@valinux.com>
To: Matthew Jacob <mjacob@feral.com>
Cc: Wakko Warner <wakko@animx.eu.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx (and sym53c8xx) plans
Message-ID: <20010214182006.B21511@valinux.com>
In-Reply-To: <20010214210351.B21191@animx.eu.org> <Pine.LNX.4.21.0102141805260.22737-100000@zeppo.feral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0102141805260.22737-100000@zeppo.feral.com>; from mjacob@feral.com on Wed, Feb 14, 2001 at 06:06:08PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Matthew Jacob:
> See http://www.freebsd.org/~gibbs/linux.

Here at VA we're already using Jason's driver -- it works on the Intel
STL2 motherboard, while Doug's driver doesn't (or didn't, a month ago).

While we're discussing SCSI drivers, I'd also like to put in a good
word for the Sym-2 Symbios/NCR drivers from Gerard Roudier:

    ftp://ftp.tux.org/roudier/drivers/portable/sym-2.1.x/

Joe-Bob says: "Check it out."
-- 
Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
   "Give me immortality, or give me death!"  // Firesign Theatre
