Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUDEXKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbUDEXKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:10:19 -0400
Received: from gizmo09bw.bigpond.com ([144.140.70.19]:22247 "HELO
	gizmo09bw.bigpond.com") by vger.kernel.org with SMTP
	id S263529AbUDEXKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:10:07 -0400
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Michael Buesch <mbuesch@freenet.de>
Subject: Re: APIC error on CPU0
Keywords: kernel
References: <200404052336.23585.mbuesch@freenet.de>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>, Michael
 Buesch <mbuesch@freenet.de>
Date: Tue, 06 Apr 2004 09:03:58 +1000
In-Reply-To: <200404052336.23585.mbuesch@freenet.de> (Michael Buesch's
 message of "Mon, 05 Apr 2004 23:35:59 +0200")
Message-ID: <microsoft-free.8765ceyqld.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

* Michael Buesch <mbuesch@freenet.de> writes:

  > What does this kernel message mean?

  > Apr  5 23:16:20 lfs kernel: APIC error on CPU0: 60(60)
  > Apr  5 23:16:31 lfs kernel: APIC error on CPU0: 60(60)

My logs are filling up with these as well, although I'm getting
40(40), and the very occasional 00(40).

I'm wondering what it means as well.

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

iEYEABECAAYFAkBx5d8ACgkQHSfbS6lLMAMITACbBUlCcBc9Zrs11r9CDiVkzsQx
7GMAn3Nz4G0/I8/zOjtTEKQYP0kJwJtV
=w7qZ
-----END PGP SIGNATURE-----
--=-=-=--
