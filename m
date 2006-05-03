Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbWECFIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWECFIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 01:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbWECFIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 01:08:48 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:62849 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP id S965089AbWECFIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 01:08:47 -0400
From: Michael Helmling <supermihi@web.de>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Date: Wed, 3 May 2006 07:06:53 +0200
User-Agent: KMail/1.9.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200605022002.15845.supermihi@web.de> <200605021509.17050.david-b@pacbell.net>
In-Reply-To: <200605021509.17050.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3103600.QLbJGWO7CL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605030706.56908.supermihi@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3103600.QLbJGWO7CL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 03 May 2006 00:09, David Brownell wrote:
> On Tuesday 02 May 2006 11:02 am, Michael Helmling wrote:
> > Hi all,
> >=20
> > I bought an USB-Ethernet adaptor from delock (www.delock.de) and found =
it=20
was=20
> > not supported by linux from the vendor. So I played a little with lsusb=
=20
and=20
> > found it uses a MCS7830 chip from MosChip semiconductor (moschip.com). =
On=20
> > their homepage I found a driver but it only was a precompiled Fedora4=20
module.=20
> > So I wrote them an email and they sent me the whole source code for the=
=20
> > module...
> >
> > Would be nice to see this supported in further kernel releases.
> > The sourcecode can be found at ftp://supermihi.myftp.org
>=20
> Was it you who removed the copyrights from the "usbnet" driver and
> changed the author assertion to one "M Subrahmanya Srihdar" ??
> I'm guessing the latter; the www.moschip.com site implies that
> its engineering HW is in India.

No, I did not change the code in any way, it is exactly the version they=20
mailed me. But I don't really understand what you are saying about the usbn=
et=20
module. They gave me the sourcecode for a yet not available kernel module=20
"mcs7830", not usbnet. Or did they just modify usbnet? I don't know enough=
=20
about such things to distinguish from both.=20
>=20
> Either way, blatant plagiarism and theft of copyright is unlikely
> to get into upstream kernels.

I personally have the feeling that they didn't do this by purpose. They wer=
e=20
very willing to help me with the driver and don't seem to understand much o=
f=20
kernel development. Anyway, if this IS a copyright violation, they should=20
really change it quickly.
>=20
> Likewise, that is NOT the way to integrate with the "usbnet" driver
> framework.  See how it's done by the "asix.c" driver module.
>=20
Sorry this isn't useful for me, I'm not a developer, more than ever no kern=
el=20
developer. ;)
>=20
> In fact, I'm very tempted to ask them to withdraw their distribution,
> since they have clearly violated pretty basic terms of the GPL.=20
Maybe you should do this, since I don't know much about the details of GPL =
and=20
my english is really bad. *g*
> How=20
> long have they been doing that?  How much money have they made by
> this theft?


>=20
> That stuff is correctible ... but until they correct their problems,
> I'm not inclined to let them continue distributing stolen software.
>=20
This is comprehensible. But, nevertheless this is the possibility of=20
supporting another hardware device in linux, and we shouldn't forsake it.


=2D Michael

--nextPart3103600.QLbJGWO7CL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEWDpwcLJiNWFgTBIRAg/OAJ0W5osTqgKRpuZVaXRBwEVoLJmpLACg5tsu
wMVe1Uj58acHo9evdPDZItQ=
=oqOb
-----END PGP SIGNATURE-----

--nextPart3103600.QLbJGWO7CL--
