Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423448AbWBBKll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423448AbWBBKll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423440AbWBBKll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:41:41 -0500
Received: from 60-240-149-171.tpgi.com.au ([60.240.149.171]:59859 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1423448AbWBBKlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:41:40 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Thu, 2 Feb 2006 20:38:11 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202100522.GB1981@elf.ucw.cz>
In-Reply-To: <20060202100522.GB1981@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1526288.eMlSYjdfQ1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602022038.16262.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1526288.eMlSYjdfQ1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 20:05, Pavel Machek wrote:
> Hi!
>
> > This set of patches represents the core of Suspend2's module support.
> >
> > Suspend2 uses a strong internal API to separate the method of
> > determining the content of the image from the method by which it is
> > saved. The code for determining the content is part of the core of
> > Suspend2, and transformations (compression and/or encryption) and stora=
ge
> > of the pages are handled by 'modules'.
>
> swsusp already has a very strong API to separate image writing from
> image creation (in -mm patch, anyway). It is also very nice, just
> read() from /dev/snapshot. Please use it.

You know that's not an option.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1526288.eMlSYjdfQ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4eEYN0y+n1M3mo0RAr3KAJ9t+FzR9EFMUKKdm93mfqJzBHxAZgCg5+CT
E9n2HaAj3GQyubbljSaKcko=
=3Apx
-----END PGP SIGNATURE-----

--nextPart1526288.eMlSYjdfQ1--
