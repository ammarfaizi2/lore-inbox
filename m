Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUAPDIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 22:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbUAPDIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 22:08:54 -0500
Received: from gizmo09bw.bigpond.com ([144.140.70.19]:42691 "HELO
	gizmo09bw.bigpond.com") by vger.kernel.org with SMTP
	id S265248AbUAPDIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 22:08:52 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Increase recursive symlink limit from 5 to 8
Keywords: limit
References: <E1AeMqJ-00022k-00@minerva.hungry.com>
	<2flllofnvp6.fsf@saruman.uio.no>
	<microsoft-free.87isjj0y1e.fsf@eicq.dnsalias.org>
	<1073814570.4431.3.camel@laptop.fenrus.com>
	<817jzsd8lg.wl@omega.webmasters.gr.jp>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Fri, 16 Jan 2004 13:08:43 +1000
In-Reply-To: <817jzsd8lg.wl@omega.webmasters.gr.jp> (GOTO Masanori's message
 of "Fri, 16 Jan 2004 09:45:47 +0900")
Message-ID: <microsoft-free.87r7y07fpg.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

* GOTO Masanori <gotom@debian.or.jp> writes:

  > But I still think 6 is too small from user level point of view

When I first saw this thread I thought "yeah, that's a low limit", but
now I'm not so sure.  

The truth is, up until a few days ago when this thread started, I
wasn't even aware that there was a limit.[1] Which means, that for me
at least, I have never had the need to exceed the limit.  Because, if
I had I would have discovered what that limit was.

I'm not an "occasional dual-booting" Linux user, I've been using Linux
_exclusively_ since late 1996.  In that 7, going on 8 years I have
_never_ hit the limit.  Does that mean that it is high enough?  For
me, yes.  For others, I can't say.


Footnotes: 
[1]  Not quite true, I knew that there probably was some sort of
     limit, I just didn't know what it was.

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

iEYEABECAAYFAkAHVb8ACgkQHSfbS6lLMAOP9ACfcI5uk9gxCzs/OGuydcdA3DLv
qxYAn2vNBmYLYj2Gqw/NbOPEriuqYt/T
=kGKL
-----END PGP SIGNATURE-----
--=-=-=--
