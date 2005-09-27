Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVI0I3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVI0I3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 04:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVI0I3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 04:29:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:60667 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964858AbVI0I3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 04:29:05 -0400
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: RSBAC <rsbac@rsbac.org>, RSBAC-Announce <rsbac-announce@rsbac.org>,
       linux-kernel@vger.kernel.org, sec@linux-sec.net,
       bugtraq@securityfocus.com
Subject: Announce: RSBAC v1.2.5 released
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Cc: announce-l@lists.adamantix.org
Date: Tue, 27 Sep 2005 10:28:41 +0200
Content-Type: multipart/signed;
  boundary="nextPart1369619.hxlX1jbtIz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509271028.49091.ao@rsbac.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1369619.hxlX1jbtIz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Rule Set Based Access Control (RSBAC) v1.2.5 has been released! Full=20
information and downloads are available at http://www.rsbac.org

RSBAC Key Features:

    * Free Open Source (GPL) Linux kernel security extension
    * Independent of governments and big companies
    * Several well-known and new security models, e.g. MAC, ACL and RC
    * Control over individual user and program network accesses
    * Fully access controlled kernel level user management
    * Any combination of models possible
    * Easily extendable: write your own model for runtime registration
    * On-access virus scanning with Dazuko interface
    * Support for current kernels in 2.4 and 2.6 series
    * Stable for production use since January 2000

Major new features in v1.2.5:

    * Complete review of all interceptions with many new ones added
    * Device attribute inheritance: Use values at type:major as=20
default for type:major:minor
    * Log remote IP address of subject in access log
    * Completely rewritten admin tools build system
    * Many smaller changes to remove bugs and improve usability
    * Complete list of changes at=20
http://download.rsbac.org/code/v1.2.5/changes-1.2.5.txt

Versions 1.2.x will be maintained as stable series with bugfix=20
releases whenever necessary. All cool new features will be in the new=20
1.3 series, which has recently been branched off, see=20
http://www.rsbac.org/todo.

=46or first tests without installation you can try the Debian based=20
RSBAC Live CD at http://livecd.rsbac.org

Please forward this announcement to whereever you think it is=20
applicable,  e.g.  local or national security lists, newspapers or=20
magazines, or your favourite Internet forum.

=46eedback is always welcome!

Amon Ott.
=2D-=20
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22

--nextPart1369619.hxlX1jbtIz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDOQLBq9yn6h5RTo8RAvZrAJ9/vIUVlhs/fyOo4At0pCQUVFdYuQCaA549
f8TA1o2WnA4RUqmyC1k5WUI=
=uyG8
-----END PGP SIGNATURE-----

--nextPart1369619.hxlX1jbtIz--
