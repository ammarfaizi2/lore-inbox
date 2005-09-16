Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbVIOTe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbVIOTe2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbVIOTe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:34:28 -0400
Received: from sls-ce5p321.hostitnow.com ([72.9.236.50]:40936 "EHLO
	sls-ce5p321.hostitnow.com") by vger.kernel.org with ESMTP
	id S965208AbVIOTe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:34:27 -0400
From: Chris White <chriswhite@gentoo.org>
Reply-To: chriswhite@gentoo.org
Organization: Gentoo
To: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic Configuration of a Kernel
Date: Fri, 16 Sep 2005 13:02:56 +0900
User-Agent: KMail/1.8.2
Cc: michal.k.k.piotrowski@gmail.com, LKML <linux-kernel@vger.kernel.org>
References: <20050915095658.68775.qmail@web51005.mail.yahoo.com>
In-Reply-To: <20050915095658.68775.qmail@web51005.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1145461.C1kf9i1hX1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509161303.03955.chriswhite@gentoo.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sls-ce5p321.hostitnow.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gentoo.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1145461.C1kf9i1hX1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 15 September 2005 18:56, Ahmad Reza Cheraghi wrote:

> > How about networking options? It can detect what
> > protocols are needed?
> > Filesystems?
>
> The Network option or the Filesystes are choosen as a
> Standard. So it will be there without checking if they
> needed or not. Because I think Protocols like TCP-IP
> or Filesystems like NTFS or expt2 has to be installed
> on the now days Systems. But if they are any
> suggestion or ideas of detecting those thing. No
> problem just send me rule that does that and I will
> updated easily on the Framework.Thats the benefit of
> this Framework.;-)

Couldn't one pull up info from /etc/fstab for filesystems?  And if it was=20
network mounts, the appropriate configuration file?  I wonder how viable th=
at=20
would be.  As far as network protocols, who knows...

Chris White

--nextPart1145461.C1kf9i1hX1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDKkP3FdQwWVoAgN4RAjGVAKDndE37rDQ9NlBi3YPb+dxv7igneACdHRx0
G+WBCJQ/mHT1Pw4I5N7cDnI=
=a6l2
-----END PGP SIGNATURE-----

--nextPart1145461.C1kf9i1hX1--
