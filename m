Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312576AbSCYVUH>; Mon, 25 Mar 2002 16:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312577AbSCYVT5>; Mon, 25 Mar 2002 16:19:57 -0500
Received: from ip68-6-164-6.sd.sd.cox.net ([68.6.164.6]:37066 "EHLO
	rei.moonkingdom.net") by vger.kernel.org with ESMTP
	id <S312576AbSCYVTr>; Mon, 25 Mar 2002 16:19:47 -0500
Date: Mon, 25 Mar 2002 13:19:35 -0800
From: Marc Wilson <msw@cox.net>
To: linux-kernel@vger.kernel.org
Cc: Steven Walter <srwalter@yahoo.com>, Marc Wilson <msw@cox.net>
Subject: Re: Screen corruption in 2.4.18
Message-ID: <20020325211935.GG5573@moonkingdom.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Steven Walter <srwalter@yahoo.com>, Marc Wilson <msw@cox.net>
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <20020323160647.GA22958@hapablap.dyn.dhs.org> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au> <200203241507.g2OF7WN26069@ls401.hinet.hr> <1017020598.420771.13343.nullmailer@bozar.algorithm.com.au> <20020325085053.GB1382@moonkingdom.net> <20020325210244.GB14966@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2002 at 03:02:44PM -0600, Steven Walter wrote:
> On Mon, Mar 25, 2002 at 12:50:53AM -0800, Marc Wilson wrote:
> > Having said that, I've been seeing odd video artifacts in xawtv windows
> > since the patch was expanded from merely clearing bit 7. :)
>=20
> Is that to say, you suspect clearing bits 5 and 6 is causing you
> trouble?  If so, by all means try the patch I posted to the list.  If
> you can't find it in the archives or google groups or whatnot, I'll send
> it to you directly.

I don't seem to have the original message, so by all means, send it along
and I'll give it a shot.  What does it apply against?  The current kernel
on the box in question is:

Linux rei 2.4.19-pre2-ac2 #2 Sun Mar 3 22:07:50 PST 2002 i686 unknown

although I can put anything else on it, if it's necessary.  I've built
2.4.19-pre3-ac6 but haven't gotten around to rebooting to it yet. :)

--=20
Marc Wilson
msw@cox.net
http://members.cox.net/msw


--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8n5RnTDNDGg1Nl+sRAtftAJ4m1/2//BlFAQYn2ENaJB1uWJCcQQCdHQWd
T4307oTCj4lPB2AKsDEDwQQ=
=dIak
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
