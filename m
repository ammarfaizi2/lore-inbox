Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135655AbRDXOlT>; Tue, 24 Apr 2001 10:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135654AbRDXOlJ>; Tue, 24 Apr 2001 10:41:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9107 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135657AbRDXOlD>;
	Tue, 24 Apr 2001 10:41:03 -0400
Date: Tue, 24 Apr 2001 10:41:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Mohammad A. Haque" <mhaque@haque.net>, ttel5535@artax.karlin.mff.cuni.cz,
        "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <E14s3wf-0002CR-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0104241038030.6992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Alan Cox wrote:

> > > It is possible to implement the entire mail system without anything running
> > > as root but xinetd.
> > 
> > You want an MDA with elevated privileges, though...
                 ^
> What role requires priviledge once the port is open ?

.forward handling may, depending on how much do you want to put into it.

