Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVBQIJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVBQIJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 03:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVBQIJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 03:09:44 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:35515 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S262179AbVBQIJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 03:09:27 -0500
Message-ID: <42145128.4030202@tequila.co.jp>
Date: Thu, 17 Feb 2005 17:09:12 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
CC: Olivier Galibert <galibert@pobox.com>, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
References: <20050214020802.GA3047@bitmover.com> <58cb370e05021404081e53f458@mail.gmail.com> <20050214150820.GA21961@optonline.net> <20050214154015.GA8075@bitmover.com> <7579f7fb0502141017f5738d1@mail.gmail.com> <20050214185624.GA16029@bitmover.com> <1108469967.3862.21.camel@crazytrain> <42131637.2070801@tequila.co.jp> <20050216154321.GB34621@dspnet.fr.eu.org> <4213E141.5040407@tequila.co.jp> <e9d587a22ff0b23ccbb6fa112377dbee@e18.physik.tu-muenchen.de>
In-Reply-To: <e9d587a22ff0b23ccbb6fa112377dbee@e18.physik.tu-muenchen.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/17/2005 04:55 PM, Roland Kuhn wrote:

> That said, it would of course be possible to improve the internal
> workflow of our emperor penguin if he used subversion, but the
> collaboration with others could not benefit the way it does with a
> changeset-based approach.

Question is then, what about keeping a main trunk with the vanialle
release, and each dev has its own branch. now at a certain point you
have to merge them. Now where is the difference between a central rep
and a de-central one.
At day X, patches from Andrew's tree have to go to Linus tree and from
his tree into the new vanialla kernel. right?
Somehow I can't see the difference here.

> Linux kernel development is hard _and_ sexy :-)

at least something :D

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCFFEojBz/yQjBxz8RAs5rAKC1i4RuDxyi3hjnRDfcjCYyRTGbNQCgsRgc
ErnefDIDGimPjjXa8cALBQc=
=lWQ8
-----END PGP SIGNATURE-----
