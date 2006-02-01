Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423001AbWBAW6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423001AbWBAW6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbWBAW6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:58:44 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:31160 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1423001AbWBAW6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:58:44 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Thu, 2 Feb 2006 08:55:06 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602020730.16916.nigel@suspend2.net> <84144f020602011345i2e395336s371786c441b9f5b2@mail.gmail.com>
In-Reply-To: <84144f020602011345i2e395336s371786c441b9f5b2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4177250.BA0s9iKG0g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602020855.12392.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4177250.BA0s9iKG0g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 07:45, Pekka Enberg wrote:
> On Wednesday 01 February 2006 23:01, Pekka Enberg wrote:
> > > I think we can call these suspend_{get|set}_modules instead i.e.
> > > without the extra '2'.
>
> On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > I wanted to avoid confusion with similar routine names Pavel might use.
> > For example, he has a resume_setup and I have a resume2_setup.
>
> Is that necessary for the mainline, though? We have only one suspend
> in the kernel, not "Pavel suspend" and "Nigel suspend", right?

Well, I'd love that to be true, but I don't believe Pavel's going to roll o=
ver=20
and say "Ok Nigel. You've got a better implementation. I'll submit patches =
to=20
remove mine." I might be wrong, and I hope I will be, but I fear they're=20
going to coexist for a while.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart4177250.BA0s9iKG0g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4TxQN0y+n1M3mo0RArDzAKDOpxF+LscLZJPtdthq2ruLysimjACgknzW
g0C2HpANCE9TW59SNOR4Lh4=
=UXpn
-----END PGP SIGNATURE-----

--nextPart4177250.BA0s9iKG0g--
