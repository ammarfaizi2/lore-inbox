Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135637AbRDXOXS>; Tue, 24 Apr 2001 10:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135646AbRDXOW6>; Tue, 24 Apr 2001 10:22:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62445 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135637AbRDXOWx>;
	Tue, 24 Apr 2001 10:22:53 -0400
Date: Tue, 24 Apr 2001 10:22:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Mohammad A. Haque" <mhaque@haque.net>, ttel5535@artax.karlin.mff.cuni.cz,
        "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <E14s3du-00029R-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0104241022040.6992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Alan Cox wrote:

> > On Tue, 24 Apr 2001, Mohammad A. Haque wrote:
> > > Correct. <1024 requires root to bind to the port.
> > ... And nothing says that it should be done by daemon itself.
> 
> Or that you shouldnt let inetd do it for you
> And that you shouldn't drop the capabilities except that bind
> 
> It is possible to implement the entire mail system without anything running
> as root but xinetd.

You want an MDA with elevated privileges, though...

