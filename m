Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbTDUVf3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTDUVe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:34:58 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:59008 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262577AbTDUVda (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:33:30 -0400
Message-Id: <200304212145.h3LLjRM8002371@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Zoltan NAGY <nagyz@piarista-kkt.sulinet.hu>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: grsecurity in 2.5? 
In-Reply-To: Your message of "Mon, 21 Apr 2003 23:37:38 +0200."
             <Pine.LNX.4.44.0304212335520.25621-100000@server.piarista-kkt.sulinet.hu> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0304212335520.25621-100000@server.piarista-kkt.sulinet.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1058320666P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Apr 2003 17:45:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1058320666P
Content-Type: text/plain; charset=us-ascii

On Mon, 21 Apr 2003 23:37:38 +0200, Zoltan NAGY said:
> On Mon, 21 Apr 2003, Greg KH wrote:
> 
> > On Sun, Apr 20, 2003 at 10:23:01AM +0200, Zoltan NAGY wrote:
> > > hi!
> > > 
> > > its a simple question.. it there a chance that grsecurity will be (even 
> > > partially) merged into 2.5?
> > 
> > What's the status of that patch being ported to the LSM interface (which
> > is already in 2.5)?
> 
> AFAIK there was a discussion about it, but i dont know what decision has 
> born.. 

Some parts of grsecurity were trivial to fit into the LSM framework.  Other
parts are basically impossible simply because LSM doesn't hook into the
code where it's needed....

--==_Exmh_1058320666P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+pGZ2cC3lWbTT17ARAuJAAKCdBaBfjEaPyBvFK2kH5LWUYlVVmwCfaYMp
5KfuAozkAnGjqHPh1Huy8h8=
=Km53
-----END PGP SIGNATURE-----

--==_Exmh_1058320666P--
