Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbUDTLo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbUDTLo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 07:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUDTLo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 07:44:57 -0400
Received: from [68.184.155.122] ([68.184.155.122]:52640 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S262742AbUDTLoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 07:44:55 -0400
Date: Tue, 20 Apr 2004 07:44:29 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: PWC and Quickcam Zoom?
Message-ID: <20040420114429.GY10510@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PLOb/g6AMdJ1vPHZ"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PLOb/g6AMdJ1vPHZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



  I just got a new Quickcam Zoom.  I compiled the pwc usb driver as a
module for my 2.6.5 kernel.  I also downloaded the latest pwcx driver
which patched in cleanly (http://www.smcc.demon.nl/webcam/release.html).
When I run camstream the window locks up dead tight and I have to reboot
to get rid of the process.  When I run motion I get this:

pwc Frame buffer overflow (flen = 582, frame_total_size = 76812).
pwc Frame buffer overflow (flen = 582, frame_total_size = 76812).
pwc Frame buffer underflow (4 bytes); discarded.
pwc Frame buffer overflow (flen = 582, frame_total_size = 76812).
pwc Frame buffer overflow (flen = 582, frame_total_size = 76812).

Anyone have any ideas?

Robert



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

With Dreams To Be A King First One Should Be A Man
					- Manowar


--PLOb/g6AMdJ1vPHZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhQ0d8+1vMONE2jsRAiH+AKCslGRBlw8nMyIoiLuv85NfcwTz1ACg6ANo
0eBeI8uHc7gIC9vSVyrmhSc=
=jNPi
-----END PGP SIGNATURE-----

--PLOb/g6AMdJ1vPHZ--
