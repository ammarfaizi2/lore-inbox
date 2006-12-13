Return-Path: <linux-kernel-owner+w=401wt.eu-S932619AbWLMIrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWLMIrM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 03:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWLMIrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 03:47:12 -0500
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:4704 "EHLO
	mse2fe2.mse2.exchange.ms" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932619AbWLMIrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 03:47:11 -0500
X-Greylist: delayed 848 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 03:47:11 EST
Subject: Re: How about an enumerated list of issues with the existing kgdb
	patches?
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: Andrew Morton <akpm@osdl.org>
Cc: Piet Delaney <piet@bluelane.com>, vgoyal@in.ibm.com,
       George Anzinger <george@wildturkeyranch.net>,
       Discussion
	 "list for crash utility usage, maintenance and development" 
	<crash-utility@redhat.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Subhachandra Chandra <schandra@bluelane.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060830200020.cd5bb3d7.akpm@osdl.org>
References: <44EC8CA5.789286A@redhat.com>
	 <20060824111259.GB22145@in.ibm.com> <44EDA676.37F12263@redhat.com>
	 <1156966522.29300.67.camel@piet2.bluelane.com>
	 <20060830204032.GD30392@in.ibm.com>
	 <1156974093.29300.103.camel@piet2.bluelane.com>
	 <20060830144822.3b8ffb9a.akpm@osdl.org>
	 <20060830155710.5865faa0.akpm@osdl.org>
	 <1156992153.24314.24.camel@piet2.bluelane.com>
	 <20060830200020.cd5bb3d7.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9YxyXY5udQV7gCk7CjVn"
Organization: Blue Lane Technologies
Date: Wed, 13 Dec 2006 00:32:58 -0800
Message-Id: <1165998778.25954.12.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
X-OriginalArrivalTime: 13 Dec 2006 08:33:02.0701 (UTC) FILETIME=[4DC229D0:01C71E91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9YxyXY5udQV7gCk7CjVn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-30 at 20:00 -0700, Andrew Morton wrote:
> On Wed, 30 Aug 2006 19:42:32 -0700
> Piet Delaney <piet@bluelane.com> wrote:
>=20
> > On Wed, 2006-08-30 at 15:57 -0700, Andrew Morton wrote:
> > > On Wed, 30 Aug 2006 14:48:22 -0700
> > > Andrew Morton <akpm@osdl.org> wrote:
> > >=20
> > > >  Plus: I'd want to see a maintainance person or team who
> > > > respond promptly to email and who remain reasonably engaged with wh=
at's
> > > > going on in the mainline kernel.  Because if problems crop up (and =
they
> > > > will), I don't want to have to be the bunny who has to worry about =
them...
> > >=20
> > > umm, clarification needed here.
> > >=20
> > > No criticism of the present maintainers intended!  Last time I grabbe=
d the
> > > kgdb patches from sf.net they applied nicely, worked quite reliably (=
much
> > > better than the old ones I'd been trying to sustain) and had been
> > > tremendously cleaned up.
> >=20
> > So why did you stop including them in the mm patch?
>=20
> Some change in 2.6.17-pre caused it to all stop working.
>=20
> > I recall your quality issue and Tom was all in favor
> > of resolving them. Was it too much work cleaning up the=20
> > patches to meet your needs that lead to the patch being
> > dropped from the mm series?
>=20
> It all seems reasonably clean now, but I haven't looked closely (nor have=
 I
> had to)

Any suggestions on how to progress?


>=20
> > kgdb over ethernet is working great, and it looks like there
> > is plenty of support on the SF mailing list. =20
>=20
> good.
>=20
> > >=20
> > > It's a big step.
> >=20
> > How about a concrete list of patch quality issues that the group
> > can address to allow your weekly addition to the mm patch as a=20
> > set toward eventually integration.
>=20
> >From whom?  me?
>=20
> > Wouldn't getting kgdb back into the mm patch series be a reasonable
> > first step eventual maintenance in kernel.org?
>=20
> Is on my todo list somewhere.
--=20
Piet Delaney                                    Phone: (408) 200-5256
Blue Lane Technologies                          Fax:   (408) 200-5299
10450 Bubb Rd.
Cupertino, Ca. 95014                            Email: piet@bluelane.com

--=-9YxyXY5udQV7gCk7CjVn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBFf7q6JICwm/rv3hoRAqwFAJ919IG7b0tGimg4xgNSeP+vSbdnjQCePAm0
SI0I4mgu6hE4i0R5osX3ym0=
=pIBB
-----END PGP SIGNATURE-----

--=-9YxyXY5udQV7gCk7CjVn--

