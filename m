Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266502AbUGBIIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbUGBIIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 04:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUGBIIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 04:08:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:25086 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266502AbUGBIIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 04:08:44 -0400
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: RSBAC <rsbac@rsbac.org>, RSBAC-Announce <rsbac-announce@rsbac.org>,
       linux-kernel@vger.kernel.org, Suse-Security <suse-security@suse.com>,
       sec@linux-sec.net, bugtraq@securityfocus.com
Subject: Announce: RSBAC v1.2.3 released
Date: Fri, 2 Jul 2004 10:06:11 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_7dR5Ajr59f5HMe+";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407021006.19888.ao@rsbac.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_7dR5Ajr59f5HMe+
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Rule Set Based Access Control (RSBAC) v1.2.3 has been released! Full=20
information and downloads are available from http://www.rsbac.org

We are also proud to announce the relaunch of our Website and a set of=20
worldwide mirrors.

RSBAC Key Features:

    * Free Open Source (GPL) Linux kernel security extension
    * Independent of governments and big companies
    * Several well-known and new security models, e.g. MAC, ACL and RC
    * Control over individual user and program network accesses
    * Any combination of models possible
    * Easily extendable: write your own model for runtime registration
    * Now includes on-access virus scanning with Dazuko interface
    * Support for current kernels in 2.4 and 2.6 series
    * Stable for production use since January 2000

Between the first upload and this announcement, the first important=20
security bugfixes had to be released, too, which also apply to previous=20
versions. You can always find the latest bugfixes at=20
http://www.rsbac.org/download/bugfixes, they are already included in some=20
of the pre-patched kernel sources (-bfX) at=20
http://www.rsbac.org/download/kernels/v1.2.3/


New features in RSBAC v1.2.3:

General:
    * Port to 2.6 kernel series with many internal changes
    * Full log separation between system and RSBAC log
    * Improved hiding of unaccessible processes

AUTH:
    * Learning mode, global and per-process

RC:
    * System boot role, now separate from root's role
    * Extra process type for kernel threads for explicit access control
    * Types for user objects

DAZ:
    * New 100% compatible Dazuko (www.dazuko.org) module
    * On-access scanning through user space antivirus daemons
    * In-kernel scanning result cache, speeding it all up significantly

ACL:
    * Global learning mode

PAX:
    * New PaX support module

JAIL:
    * Several security related and other bugfixes (it is strongly=20
      recommended to update)
    * Linux capability restrictions for jailed processes

MAC:
    * Trusted-for-user list instead of single value


Please forward this announcement to where you think it is applicable, e.g.=
=20
local or national security lists, newspapers or magazines, or your=20
favourite Internet forum.

=46eedback is always welcome!

Amon.
=2D-=20
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22

--Boundary-02=_7dR5Ajr59f5HMe+
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA5Rd7q9yn6h5RTo8RAkgTAJ4lfSsmkQWe224TUSZBbh9kv4B70QCfcxkU
x+mqnze6UbW8MSHYzKeoe1A=
=c29Y
-----END PGP SIGNATURE-----

--Boundary-02=_7dR5Ajr59f5HMe+--
