Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274879AbRIVAJF>; Fri, 21 Sep 2001 20:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274878AbRIVAIz>; Fri, 21 Sep 2001 20:08:55 -0400
Received: from pc2-camb6-0-cust223.cam.cable.ntl.com ([213.107.107.223]:8320
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S274880AbRIVAIm>; Fri, 21 Sep 2001 20:08:42 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check 
In-Reply-To: Message from Ignacio Vazquez-Abrams <ignacio@openservices.net> 
   of "Fri, 21 Sep 2001 02:11:15 EDT." <Pine.LNX.4.33.0109210209520.21008-100000@terbidium.openservices.net> 
In-Reply-To: <Pine.LNX.4.33.0109210209520.21008-100000@terbidium.openservices.net> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_588591943P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 22 Sep 2001 01:08:55 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E15kaLn-0002Lf-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_588591943P
Content-Type: text/plain; charset=us-ascii

>DMA0 is reserved for memory refresh. It _can't_ be used for anything else,
>therefore a value of 0 is representative of no value whatsoever.

On a PC/XT, perhaps.  On any other computer, nothing of the sort is guaranteed.

p.


--==_Exmh_588591943P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 (debian)

iD8DBQE7q9aXVTLPJe9CT30RAlkmAJ4irDyUyU3i7fG7PwroZUjrkZlQiwCcCCuY
hw85BK7m5Y0b2AgaDn8HORw=
=eY96
-----END PGP SIGNATURE-----

--==_Exmh_588591943P--
