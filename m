Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286532AbRLUKch>; Fri, 21 Dec 2001 05:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286540AbRLUKc1>; Fri, 21 Dec 2001 05:32:27 -0500
Received: from freeside.ultraviolet.org ([192.215.175.10]:30217 "HELO
	ultraviolet.org") by vger.kernel.org with SMTP id <S286532AbRLUKcM>;
	Fri, 21 Dec 2001 05:32:12 -0500
Date: Fri, 21 Dec 2001 03:07:06 -0800
From: Tracy R Reed <treed@ultraviolet.org>
To: Kevin <kevin@pheared.net>
Cc: Jason Czerak <Jason-Czerak@Jasnik.net>, linux-kernel@vger.kernel.org
Subject: Re: Suggestions for linux security patches
Message-ID: <20011221030706.A4518@ultraviolet.org>
Mail-Followup-To: Tracy R Reed <treed@ultraviolet.org>,
	Kevin <kevin@pheared.net>, Jason Czerak <Jason-Czerak@Jasnik.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1008794926.842.6.camel@neworder> <Pine.GSO.4.40.0112200017280.1846-100000@eclipse.pheared.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.40.0112200017280.1846-100000@eclipse.pheared.net>; from kevin@pheared.net on Thu, Dec 20, 2001 at 12:19:41AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 20, 2001 at 12:19:41AM -0500, Kevin wrote:
> Has anyone tried the NSA linux security setup?  I've looked it over but
> haven't gone so far as to actually run it.

I have and it is very impressive. It looks much more manageable and more
flexible than LIDS. I have played with LIDS quite extensively but having
used both now I really prefer the concept of processes running in
different domains over just assigning capabilities. I'm still learning how
to configure SE Linux though. They are both rather daunting.

--=20
Tracy Reed      http://www.ultraviolet.org
If Microsoft built cars instead of software, the airbag system would say
"Are you sure?" before going off.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjwjF9kACgkQ9PIYKZYVAq2yNgCffX9+CDX5O4f+N3D+trVDb+wc
+8sAn2RZsBgL6xxHPxGlkA5+gyc+FcMF
=fQJF
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
