Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264912AbUFLTxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbUFLTxO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 15:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUFLTxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 15:53:13 -0400
Received: from ns.schottelius.org ([213.146.113.242]:21120 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S264912AbUFLTxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 15:53:10 -0400
Date: Sat, 12 Jun 2004 21:55:47 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Nico Schottelius <nico-kernel@schottelius.org>, Amon Ott <ao@rsbac.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dev@grsecurity.net
Subject: Re: security patches / lsm
Message-ID: <20040612195547.GA597@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Chris Wright <chrisw@osdl.org>, Amon Ott <ao@rsbac.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dev@grsecurity.net
References: <20040122191158.GA1207@schottelius.org> <20040122150937.A8720@osdlab.pdx.osdl.net> <20040609090346.GG601@schottelius.org> <20040609104025.A21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20040609104025.A21045@build.pdx.osdl.net>
X-MSMail-Priority: (u_int) -1
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Chris Wright [Wed, Jun 09, 2004 at 10:40:25AM -0700]:
> * Nico Schottelius (nico-kernel@schottelius.org) wrote:
> > Sorry for the late answer!
> >=20
> > For me it looks like rsbac and grsecurity could get included in 2.6.
> >=20
> > It looks like Amon did the work necessary to intergrate it into 2.6.
> > (have a look at http://www.rsbac.org/).
> >=20
> > And grsecurity also works nice with 2.6
> > (http://www.grsecurity.net/download.php).
> >=20
> > Who decides whether to integrate them or not?
>=20
> Ultimately, that's Linus, often with some input from the rest of
> the community.  Look, it's very simple.  Create patches, submit for
> public review, update according to feedback, resubmit, etc.

Thought so, too.

> The main
> problem here is the patches above are invasive and considering where
> we are in the 2.6 series (read: concerned utmost about stability) large
> invasive patches aren't appropriate.

Ok. So waiting for 2.7 is much more senseful.

> Further, there's an infrastructure
> designed to support some of the features in the above patchsets, LSM.

As stated by Amon and others, LSM seems not to be the perfect thing.

> And the idle complaints that it's inadequate without engaging in dialog
> or supplying patches don't work very far towards a solution.
=20
Well, where do you think should we discuss that? I think Amon
doesn't avoid this discussion.

Have a nice rest-weekend,

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nerd-hosting.net | http://nico.schotteli.us

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQIVAwUBQMtfv7OTBMvCUbrlAQKaYQ//edeyLiu4MznT+7pgO9udjc+I0yrP+ynP
GYQP1JmejGXroNOrwbKNlhE5qX8ykgJcd/eT/Claiagto1T2/N7CkR/O+QYnHdCE
sn6hiNfgFwrSaiUlhex5kt5lGM+c7FUD64HpF/dw3um4RPlO1tFqtBOjpxCSOyB8
Eu9n3g4S7mBLZUFgIE79pEcStRRXt3fWTSCIlOgMifHi9TIHLpsbl+k3bkbbSnzl
l2ILZWoKa62yVYMiUZxOqsDBfYV+93Z/RUkxteKtWFB29Jvfe+uLNG9dFoG+HSZI
YpN7050xCQ5LOVxVQZQh13LJAHYVaLi3/zBGxvFPOuEmEs3WF03cj0ktrJH4kvSc
o1b//FFAQnNDnB6Kz5jmAyvBbjyt/kcQYWb0+WG2I4w9YAlCVc1C6NJqhmxE7MVb
sFviE0UN7kjSOD99nRDQz5wzbu7WgbVWPDvMY+72stAfwFQmlKYCJQQCvYox/bNl
nvFd47IdiqAdcWLjPKILWmRmTk0g1yTIHUD7M0/bxkWAva6/nJfWm60TFBjMsJrf
ykabXcr/Yej4GDvPDxtA7/8alawFU9b3/qs5hcFUmVtGPsEVW+UXRBXtfcZZhB34
IoHmoqnb80fQji61lbmbGh/xfEuLTr8NUyKrM0sYh4TZP7xpQzdFgqbDlbKR6YMc
ztlcKtDfwTw=
=2UEc
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
