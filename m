Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263740AbRFCTUX>; Sun, 3 Jun 2001 15:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263711AbRFCSSE>; Sun, 3 Jun 2001 14:18:04 -0400
Received: from pc2-camb6-0-cust223.cam.cable.ntl.com ([213.107.107.223]:56199
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S263001AbRFCSRv>; Sun, 3 Jun 2001 14:17:51 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: green@linuxhacker.ru (Oleg Drokin), laughing@shared-source.org (Alan Cox),
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Sun, 03 Jun 2001 12:19:52 BST." <E156VvF-0004D1-00@the-village.bc.nu> 
In-Reply-To: <E156VvF-0004D1-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1324527280P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 03 Jun 2001 19:16:32 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E156cQW-0005yX-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1324527280P
Content-Type: text/plain; charset=us-ascii

>> How about people from StrongArm sa11x0 port, who have USB host controller (i
>n
>> sa1111 companion chip) but do not have PCI?
>
>The strongarm doesnt have a USB master but a slave.

Like he said, the SA-1111 includes a USB master.  See, err,
<http://developer.intel.com/design/strong/1111_brf.htm>

The SA-1110 itself includes a slave.

p.



--==_Exmh_1324527280P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 (debian)

iD8DBQE7Gn8AVTLPJe9CT30RAmfvAJ0ZbDUbHBxGiby/E1EU5fsU6J9L7ACfXBC1
9UDT94xUbyoo8IcbSJw0Prg=
=QRgn
-----END PGP SIGNATURE-----

--==_Exmh_1324527280P--
