Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129784AbQLEV1e>; Tue, 5 Dec 2000 16:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129985AbQLEV1N>; Tue, 5 Dec 2000 16:27:13 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:56837 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129784AbQLEV1L>; Tue, 5 Dec 2000 16:27:11 -0500
Date: Tue, 5 Dec 2000 14:55:41 -0600
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Cc: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Athlon CPU [long]
Message-ID: <20001205145541.E6567@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.30.0012051135361.1881-200000@lt.wsisiz.edu.pl> <Pine.LNX.4.30.0012050613240.620-100000@asdf.capslock.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0012050613240.620-100000@asdf.capslock.lan>; from mharris@opensourceadvocate.org on Tue, Dec 05, 2000 at 06:17:39AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Lukasz Trabinski]
> > I know about it, but the compiler does.

[Mike A. Harris]
> Not sure what you mean however no part of the linux kernel ever uses
> glibc at all. It is not possible to do so in fact.

He means that gcc is linked to libc, so a libc bug could possibly
affect gcc.  I have not, however, ever heard of that happening.

> Your hardware is likely faulty, especially if it conks out in a
> different spot each time.

Yes.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
