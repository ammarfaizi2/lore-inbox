Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVAKF4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVAKF4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 00:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVAKF4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 00:56:07 -0500
Received: from h80ad2572.async.vt.edu ([128.173.37.114]:7951 "EHLO
	h80ad2572.async.vt.edu") by vger.kernel.org with ESMTP
	id S262416AbVAKF4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 00:56:04 -0500
Message-Id: <200501110554.j0B5sqmc029967@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS 
In-Reply-To: Your message of "Mon, 10 Jan 2005 19:43:07 +0100."
             <20050110184307.GB2903@stusta.de> 
From: Valdis.Kletnieks@vt.edu
References: <20050110184307.GB2903@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1105422892_27063P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jan 2005 00:54:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1105422892_27063P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Jan 2005 19:43:07 +0100, Adrian Bunk said:

> Remote host said: 417 SPF error mailout.stusta.mhn.de: Address does not 
> pass the
> +Sender Policy Framework

I'd recommend sitting on this patch for a week.  If they haven't noticed by
then that they're not accepting mail from anyplace on the Internet that
doesn't advertise an SPF record (which is most of the net, still), then
we don't need to be pointing MAINTAINERS there.

>  W83L51xD SD/MMC CARD INTERFACE DRIVER
>  P:	Pierre Ossman
> -M:	drzeus-wbsd@drzeus.cx
> -L:	wbsd-devel@list.drzeus.cx
>  W:	http://projects.drzeus.cx/wbsd
>  S:	Maintained

--==_Exmh_1105422892_27063P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB42oscC3lWbTT17ARAmAbAJoCOR+X8PI/OFZ94Q6WfFl2iWJcTQCbByrd
VzLzy+fO28AnWtb8z1LRtRk=
=jdHL
-----END PGP SIGNATURE-----

--==_Exmh_1105422892_27063P--
