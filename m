Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbUAKBEg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 20:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265634AbUAKBEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 20:04:35 -0500
Received: from gizmo13ps.bigpond.com ([144.140.71.23]:5583 "HELO
	gizmo13ps.bigpond.com") by vger.kernel.org with SMTP
	id S265631AbUAKBE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 20:04:27 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: ALSA Team <alsa-devel@alsa-project.org>
Subject: Problem with loading ALSA mods - kernel 2.6.1
Keywords: kernel
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Now-Playing: Alive & Brilliant --- [Deborah Conway]
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>, ALSA
 Team <alsa-devel@alsa-project.org>
Date: Sun, 11 Jan 2004 11:04:16 +1000
Message-ID: <microsoft-free.87r7y7wb1r.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

When my sound modules load I'm getting this in the logs...

kernel: request_module: failed /sbin/modprobe -- sound-slot-0. error = 256
kernel: PCI: Found IRQ 10 for device 0000:00:09.0
kernel: modprobe: page allocation failure. order:4, mode:0x20

The modules load and sound works as expected.

What's that "page allocation failure" all about?

-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAkAAoRMACgkQHSfbS6lLMAMfFgCeLoSWcrME7PQyrAsHjJ9pTYEw
t0oAoNluNA76SSghyrGJpZQs75TXLTdS
=alL9
-----END PGP SIGNATURE-----
--=-=-=--
