Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263895AbRFNShH>; Thu, 14 Jun 2001 14:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263909AbRFNSg5>; Thu, 14 Jun 2001 14:36:57 -0400
Received: from 23290-8.wrls.cody.wy.vcn.com ([209.193.89.74]:61680 "HELO
	noir.kain.org") by vger.kernel.org with SMTP id <S263895AbRFNSgt>;
	Thu, 14 Jun 2001 14:36:49 -0400
Date: Thu, 14 Jun 2001 12:36:29 -0600
From: Kain <kain@kain.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Bigmem support (4 gigas) is stable?
Message-ID: <20010614123628.C23237@noir.kain.org>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3B275494.D7DA6413@barcelo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3B275494.D7DA6413@barcelo.com>; from m.colom@barcelo.com on Wed, Jun 13, 2001 at 01:55:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2001 at 01:55:00PM +0200, Miquel Colom Piza wrote:
> I should add 1 giga of RAM to a machine which already has 1 giga. I know
> I will have to configure bigmem support in the kernel (2.2.19). I would
> like to know if this option is considered really stable and tested or I
> can expect some problems, because this is a heavy loaded critical server
> and in case of doubt I'll habilitate another server instead of  giving
> more RAM to the one I already use.

I have a gigabyte GA-7DXR (athlon 1.33ghz) with 1.25GB of ram pumping out 1=
00,000 postgresql database-driven emails per hour with 2.4.5-ac7, so I figu=
re it's fine.
--=20
Confucious say:
        passionate kiss like spider web, lead to undoing of fly.
**
Sadistic Pacifist
Bryon Roche, Kain <kain@kain.org>

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7KQQsBK2G/mh4q9URAmb/AJ9bCUw+hpVAXb90ixxIOabnRcdP9wCfQsf0
Q9FD7WxUOm9aiUPO2/SLYpI=
=b+TS
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
