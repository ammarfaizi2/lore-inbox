Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262195AbRE2WQc>; Tue, 29 May 2001 18:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262191AbRE2WQX>; Tue, 29 May 2001 18:16:23 -0400
Received: from pc1-camb6-0-cust57.cam.cable.ntl.com ([62.253.135.57]:2944 "EHLO
	kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S262186AbRE2WQM>; Tue, 29 May 2001 18:16:12 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: empeg-car serial-over-USB driver
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-987637839P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 29 May 2001 23:16:08 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E154rma-00009D-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-987637839P
Content-Type: text/plain; charset=us-ascii

Has anybody used this successfully in a recent kernel?  With 2.4.5 it seems to 
detect the device successfully:

empeg.c: v1.0.0 Greg Kroah-Hartman <greg@kroah.com>, Gary Brubaker <xavyer@ix.netcom.com>
empeg.c: USB Empeg Mark I/II Driver
usbserial.c: Empeg converter detected
usbserial.c: Empeg converter now attached to ttyUSB0 (or usb/tts/0 for devfs)

but the machine locks up when I try to talk to it.  This is on i386 using the 
usb-uhci driver.

p.



--==_Exmh_-987637839P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 (debian)

iD8DBQE7FB+nVTLPJe9CT30RAtZAAJ4xnBR9s6750zql3lXeE+xxiDNrLgCeMfmW
ZlFrFMOrfpsk8P+11Oip9Wg=
=tAPa
-----END PGP SIGNATURE-----

--==_Exmh_-987637839P--
