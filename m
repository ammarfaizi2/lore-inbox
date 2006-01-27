Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWA0LyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWA0LyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 06:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWA0LyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 06:54:18 -0500
Received: from sipsolutions.net ([66.160.135.76]:5131 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932457AbWA0LyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 06:54:17 -0500
Subject: Re: [-mm patch] drivers/net/wireless/tiacx/: remove code for
	WIRELESS_EXT < 18
From: Johannes Berg <johannes@sipsolutions.net>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Adrian Bunk <bunk@stusta.de>, acx100-devel@lists.sourceforge.net,
       "John W. Linville" <linville@tuxdriver.com>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200601271219.24332.vda@ilport.com.ua>
References: <20060122171104.GC10003@stusta.de>
	 <200601271219.24332.vda@ilport.com.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BZgCl9m4f2iAlTliCzPJ"
Date: Fri, 27 Jan 2006 12:49:17 +0100
Message-Id: <1138362557.5983.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BZgCl9m4f2iAlTliCzPJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-01-27 at 12:19 +0200, Denis Vlasenko wrote:

> I very much want to get rid of all remaining compat cruft, and
> I plan to do it as soon as acx will be present in mainline kernel.

I doubt you'll get it merged with the compat cruft.

johannes

--=-BZgCl9m4f2iAlTliCzPJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ9oIvaVg1VMiehFYAQK7ww//R6MPscMPsF7OvWzO8pwiMpU0BwJDtqMF
dHHdVIWWQ3jfvVpgPZNDbBkuKDFbTd1JcHlgHdZhAqPRux31JA6G/MJny4JsYbjW
ZgzjzKl8rzMNGD3Y/kHRkE2VrXaT48fvgggHW94BLhQ0uunQJPayBvO+SixghstE
bPypPoiSgz/cRJBbn9g1ofWVr78QX/Vra+B+E2sRtWSvUpDVnn4JdEshQGLmU0Rd
deucPBHOrHfgeLPReP7D9rn4UrmEpKgIqXSI9CA2JVcoWseNqu74PEDIFW1MwAHJ
MVxwZBXk8+25gRYTN/9ok2ryuFP3KmHpscBelnUgeoHZ0wCBd4IIlrnPlTLe/Q7F
jsRWS9zcstb2UlDnq5j1NSXfzWzDIPD8rZGjz62TEhnCikvTeZmzXxRC3vXZ+eQP
gQv/d0jsqqaO3bgTmnVRZQ7/Lp6s4qQ3agV4hadv2Fn78hJyOkWJ2ScQYK+AY+0H
VVOn+z2UTA7ZCKHGlTMCjwS+R0OMKyOm2/Bhp0UbhdKigid3sTOjnqbj+m/+DJst
653UCHzW9fkaUiMs4wIKb5+HMNDdsEdEc4n4Xi/9xnoHgqYx5F+/uSSYHgeTPABa
RFCZMh+i73n1+k7Joez/oDTZPA5/iiB6erS+nNNvbEnGkfPDVFTTTzIr7H/ZofTd
fVSoR+Mvjo4=
=HRrl
-----END PGP SIGNATURE-----

--=-BZgCl9m4f2iAlTliCzPJ--

