Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVBQJ1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVBQJ1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 04:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVBQJ1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 04:27:21 -0500
Received: from hamlet.e18.physik.tu-muenchen.de ([129.187.154.223]:15063 "EHLO
	hamlet.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S262180AbVBQJ1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 04:27:14 -0500
In-Reply-To: <42145128.4030202@tequila.co.jp>
References: <20050214020802.GA3047@bitmover.com> <58cb370e05021404081e53f458@mail.gmail.com> <20050214150820.GA21961@optonline.net> <20050214154015.GA8075@bitmover.com> <7579f7fb0502141017f5738d1@mail.gmail.com> <20050214185624.GA16029@bitmover.com> <1108469967.3862.21.camel@crazytrain> <42131637.2070801@tequila.co.jp> <20050216154321.GB34621@dspnet.fr.eu.org> <4213E141.5040407@tequila.co.jp> <e9d587a22ff0b23ccbb6fa112377dbee@e18.physik.tu-muenchen.de> <42145128.4030202@tequila.co.jp>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-37--671269379"
Message-Id: <e030fd01c5625a80b90382e69843213f@e18.physik.tu-muenchen.de>
Content-Transfer-Encoding: 7bit
Cc: Olivier Galibert <galibert@pobox.com>, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Re: [BK] upgrade will be needed
Date: Thu, 17 Feb 2005 10:27:13 +0100
To: Clemens Schwaighofer <cs@tequila.co.jp>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-37--671269379
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Clemens!

On Feb 17, 2005, at 9:09 AM, Clemens Schwaighofer wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 02/17/2005 04:55 PM, Roland Kuhn wrote:
>
>> That said, it would of course be possible to improve the internal
>> workflow of our emperor penguin if he used subversion, but the
>> collaboration with others could not benefit the way it does with a
>> changeset-based approach.
>
> Question is then, what about keeping a main trunk with the vanialle
> release, and each dev has its own branch. now at a certain point you
> have to merge them. Now where is the difference between a central rep
> and a de-central one.
> At day X, patches from Andrew's tree have to go to Linus tree and from
> his tree into the new vanialla kernel. right?
> Somehow I can't see the difference here.
>
The difference comes after the merge. Suppose Andrew didn't push 
everything to Linus. Then new patches come in, both trees change. In 
this situation it is very time consuming with subversion to work out 
the changes which still have to go from Andrew's tree to Linus' tree.

Ciao,
					Roland

--
TU Muenchen, Physik-Department E18, James-Franck-Str. 85747 Garching
Telefon 089/289-12592; Telefax 089/289-12570
--
A mouse is a device used to point at
the xterm you want to type in.
Kim Alm on a.s.r.

--Apple-Mail-37--671269379
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFCFGNxI4MWO8QIRP0RAlHfAKC9XrKQ6QUJyXbMn+/7wU4vxSerewCbB8jM
D/Xt2jQHRXoxb9dz/I85fbE=
=SnFt
-----END PGP SIGNATURE-----

--Apple-Mail-37--671269379--

