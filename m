Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbTFQNHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 09:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264711AbTFQNHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 09:07:51 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:1177 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264709AbTFQNHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 09:07:49 -0400
Date: Tue, 17 Jun 2003 09:19:47 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: Re: Problems with PCMCIA/Orinoco
In-reply-to: <Pine.LNX.4.44.0306171159470.1854-100000@blackstar.nl>
To: bvermeul@blackstar.nl
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Message-id: <20030617131947.GA20383@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=gKMricLos+KVdGMg;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
References: <20030617105544.D25452@flint.arm.linux.org.uk>
 <Pine.LNX.4.44.0306171159470.1854-100000@blackstar.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2003 at 12:01:40PM +0200, bvermeul@blackstar.nl wrote:
> > > unregister_netdevice: waiting for eth1 to become free. Usage count =
=3D 1
> > > The net device is an Orinoco mini-pci card (eg, cardbus minipci inter=
face=20
> > > with built-in orinoco card), and it is down.
> I'm also using a RTL8139 cardbus card, and that does not show this=20
> particular problem (works great actually).
> So I'm not so sure it is a netdevice problem. It may be a orinoco
> problem, but I'm not entirely sure what's causing it.
> Just wanted to see if anyone's noticed it as well, and if a fix was
> out there.

i've been seeing the problem for a while with my orinoco_cs and
3c574_cs, so you're not alone.  i'm using debian unstable.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7xVzCGPRljI8080RApRLAJ90sDtFZkbBWILOsCJmXO//4Jg5rACgkcq7
ZHXmOej/u7zK+rRNEk6ufFc=
=DFob
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
