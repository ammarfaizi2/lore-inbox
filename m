Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWFHDUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWFHDUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 23:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWFHDUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 23:20:35 -0400
Received: from pool-72-66-198-190.ronkva.east.verizon.net ([72.66.198.190]:20164
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932476AbWFHDUe (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 23:20:34 -0400
Message-Id: <200606080319.k583JvjB004726@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm1
In-Reply-To: Your message of "Thu, 08 Jun 2006 00:11:42 +0200."
             <20060607221142.GB6287@elte.hu>
From: Valdis.Kletnieks@vt.edu
References: <20060607104724.c5d3d730.akpm@osdl.org> <200606072354.41443.rjw@sisk.pl>
            <20060607221142.GB6287@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149736796_3858P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Jun 2006 23:19:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149736796_3858P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Jun 2006 00:11:42 +0200, Ingo Molnar said:
> > On Wednesday 07 June 2006 19:47, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
> > > 
> > > - Many more lockdep updates
> could you try the current lock validator combo patch from:
> 
>   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc6-mm1.patch

Seems to be making progress.  With this lockdep-combo, I've been up for
40 minutes without a peep.

(I admit I didn't check the base rc6-mm1 version, because I knew my config
trips on the same unix_stream_connect that Rafael hit, and Rafael and
Ingo posted while I was off doing other stuff...)


--==_Exmh_1149736796_3858P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEh5dccC3lWbTT17ARAldeAKCyvbq3iGhyOWx4ViLMMKsGkXGTvgCgvpSQ
edAnneKcUNULxMnKpuej7Gg=
=JmM3
-----END PGP SIGNATURE-----

--==_Exmh_1149736796_3858P--
