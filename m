Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281473AbRLBRH4>; Sun, 2 Dec 2001 12:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280012AbRLBRHq>; Sun, 2 Dec 2001 12:07:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48657 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281512AbRLBRH2>; Sun, 2 Dec 2001 12:07:28 -0500
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 2 Dec 2001 17:14:43 +0000 (GMT)
Cc: pierre.rousselet@wanadoo.fr (Pierre Rousselet),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0112021150310.12801-100000@binet.math.psu.edu> from "Alexander Viro" at Dec 02, 2001 11:59:34 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16AaCR-0003wy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Here is the final (i hope) verdict of my devfs testbox :
> > 
> > 2.4.16 with devfsd-1.3.18/1.3.20 : OK
> > 2.4.17-pre1         "            : Broken
> > 2.5.1-pre1          "            : OK

Sounds like the new devfs code should be backed out of 2.4 until fixed
in 2.5 

Alan
