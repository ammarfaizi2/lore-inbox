Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbUKNKL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUKNKL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 05:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbUKNKL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 05:11:27 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:15267 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261277AbUKNKLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 05:11:14 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Luc Saillard <luc@saillard.org>
Subject: Re: pwc driver status?
Date: Sun, 14 Nov 2004 11:11:34 +0100
User-Agent: KMail/1.7.1
Cc: Gergely Nagy <algernon@bonehunter.rulez.org>, linux-kernel@vger.kernel.org
References: <200411132134.52872.lkml@kcore.org> <1100380178.16772.23.camel@melkor> <20041113211816.GC22949@sd291.sivit.org>
In-Reply-To: <20041113211816.GC22949@sd291.sivit.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart26844521.QsEBmTat4S";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411141111.38951.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart26844521.QsEBmTat4S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 13 November 2004 22:18, Luc Saillard wrote:
> On Sat, Nov 13, 2004 at 10:09:38PM +0100, Gergely Nagy wrote:
> > > Unfortunately, upgrading is not an option right now for other
> > > reasons...
> >
> > That's a pity... because there is no 2.4 version of Luc's driver as far
> > as I know :(
>
> I don't use a 2.4 kernel, so i can produce patch for older kernel, but i'=
ll
> not test them. If someone want a 2.4 kernel tell me, and i'll try to mande
> a patch using difftools. I prefer to add features like v4l2, than
> supporting and testing old kernel (or writing documentation).

Understandable. I'll look into getting the other box upgraded, tho the owne=
r=20
of it is kinda reluctant to do so.

>
> > > Is this driver also supporting the Logitech Quickcam for Notebooks? I
> > > found some references that the 'official' one used to do that, but I
> > > can't find much docs...
> >
> > As far as I know, yes. The source code seems to indicate the same.
>
> If the old driver supports, mine too (minor some very old webcam).

Ok, good to know. Would be nice tho to have some actual 'confirmation' of t=
his=20
fact before I run off to spend money ;p

Jan

=2D-=20
You may be gone tomorrow, but that doesn't mean that you weren't here today.

--nextPart26844521.QsEBmTat4S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBly9aUQQOfidJUwQRAsLLAJ4hBlAtJ4pfdQ3+cwfo5YUJOaDapgCffLYy
3ySONtMN59Mr/qufnwZPE7w=
=u/x9
-----END PGP SIGNATURE-----

--nextPart26844521.QsEBmTat4S--
