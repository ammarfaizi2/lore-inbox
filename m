Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVCJDqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVCJDqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVCJDpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 22:45:34 -0500
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:17937 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S262616AbVCJDn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 22:43:58 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
Organization: IBM LTC
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bk commits and dates
Date: Thu, 10 Mar 2005 14:44:01 +1100
User-Agent: KMail/1.7.2
References: <1110422519.32556.159.camel@gaston>
In-Reply-To: <1110422519.32556.159.camel@gaston>
MIME-Version: 1.0
Message-Id: <200503101444.01651.michael@ellerman.id.au>
Content-Type: multipart/signed;
  boundary="nextPart1774990.YyQLdOhLj6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1774990.YyQLdOhLj6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Two's company ...

On Thu, 10 Mar 2005 13:41, Benjamin Herrenschmidt wrote:
> While we are at such requests ...
>
> When you pull from one of the trees, like netdev, the commit messages
> are sent to the bk commit list with the original date stamp of the patch
> in the netdev tree.
>
> For example, if Jeff commited a patch from somebody in his netdev tree 3
> weeks ago, and you pull Jeff's tree today, we'll get all the commit
> messages today, but dated from 3 weeks ago.
>
> That means that in my mailing list archive, where my mailer sorts them
> by date, I can't say, for example, everything that is before the 2.6.11
> tag release was in 2.6.11. It's also difficult to spot "new" stuffs as
> they can arrive with dates weeks ago, and thus show up in places I will
> not look for.
>
> I don't know if I'm the only one to have a problem with that, but it
> would be nice if it was possible, when you pull a bk tree, to have the
> commit messages for the csets in that tree be dated from the day you
> pulled, and not the day when they went in the source tree.
>
> Ben.



--nextPart1774990.YyQLdOhLj6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCL8KBdSjSd0sB4dIRAtQXAKCuUlgpPbbQMYEYjeD2bDBJ1Pm3EACbBhC7
Sc6R91/cQSqNIYC1IAboDiE=
=OePl
-----END PGP SIGNATURE-----

--nextPart1774990.YyQLdOhLj6--
