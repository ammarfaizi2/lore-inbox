Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbTGXTdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 15:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270022AbTGXTdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 15:33:17 -0400
Received: from main.gmane.org ([80.91.224.249]:41430 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270009AbTGXTdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 15:33:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Switching kernel from GPL
Date: Thu, 24 Jul 2003 12:49:01 -0700
Message-ID: <m265lr3dua.fsf@tnuctip.rychter.com>
References: <200307241841.h6OIfvRn000613@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:PJqDIh2FP1gL+1a6p6OVRCJOumY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "John" =3D=3D John Bradford <john@grabjohn.com> writes:
 John> There has been some discussion on the list about the possibility
 John> of getting parts and possibly eventually all of the kernel
 John> re-licensed under another license, which is in the same spirit as
 John> the GPL.

 John> Something to note is that even with the consent of all copyright
 John> holders, this may not be possible - there is at least one patent,
 John> (Read, Copy, Update), which is usable in GPL'ed code, but not
 John> necessarily in code covered by another license.  That issue would
 John> need to be discussed with the patent holders.
[...]

I found it interesting that there was no mention of patents in these GPL
discussions until now. The "anti-patent" clauses in the GPL and LGPL are
quite possibly the biggest problem preventing the use of GPL'd software
by commercial entities, much bigget than the "pass on the source and the
rights" requirement.

An excerpt from the GPL:

     7. If, as a consequence of a court judgment or allegation of patent
   infringement or for any other reason (not limited to patent issues),
   conditions are imposed on you (whether by court order, agreement or
   otherwise) that contradict the conditions of this License, they do not
   excuse you from the conditions of this License.  If you cannot
   distribute so as to satisfy simultaneously your obligations under this
   License and any other pertinent obligations, then as a consequence you
   may not distribute the Program at all.  For example, if a patent
   license would not permit royalty-free redistribution of the Program by
   all those who receive copies directly or indirectly through you, then
   the only way you could satisfy both it and this License would be to
   refrain entirely from distribution of the Program.
 [...]
     8. If the distribution and/or use of the Program is restricted in
   certain countries either by patents or by copyrighted interfaces, the
   original copyright holder who places the Program under this License
   may add an explicit geographical distribution limitation excluding
   those countries, so that distribution is permitted only in or among
   countries not thus excluded.  In such case, this License incorporates
   the limitation as if written in the body of this License.

As I understand it (and as my legal counsel advises me) this effectively
means that if I distribute GPL code, I have to make sure that its
distribution and re-distribution is not restricted by patents (or other
reasons).=20

If the code in question contains parts which some patents lay claim to,
restricting distribution, then I must not distribute the code at
all. Furthermore, by distributing the code I breach the GPL and expose
myself to legal threat of a lawsuit from the FSF.

It is needless to mention that it is impossible to me to verify that no
patents (worldwide!) lay claim to the code I'm distributing and impose
restrictions upon its distribution.

An example of a particularly clear case of this problem is the XviD code
(http://www.xvid.org/), which is GPL-licensed. It seems to me that the
authors (copyright holders, to be precise) may distribute the software
under any license they choose, but nobody else is allowed to
re-distribute it, because they would be violating section 7 of the GPL,
as the MPEG-4 compression is (in some countries) covered by patents
requiring royalties to be paid.

This is an issue which is very often overlooked in the hot GPL
debates. However, in the commercial world, it is possibly the most
important one.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD4DBQA/IDgvLth4/7/QhDoRAiUhAJ4+62buUrNO0+rvAyaQ+kX/xwxeqACXV9GW
8pLqv3bUcTN33q6QvMkL6g==
=T1v4
-----END PGP SIGNATURE-----
--=-=-=--

