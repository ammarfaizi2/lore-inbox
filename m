Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTINCSc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 22:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbTINCSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 22:18:32 -0400
Received: from adsl-67-124-157-90.dsl.pltn13.pacbell.net ([67.124.157.90]:736
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S262278AbTINCSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 22:18:30 -0400
Date: Sat, 13 Sep 2003 19:18:29 -0700
To: linux-kernel@vger.kernel.org
Cc: folkert@vanheusden.com
Subject: Re: logging when SIGSEGV is processed?
Message-ID: <20030914021829.GA9117@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org,
	folkert@vanheusden.com
References: <200309140328.54920.folkert@vanheusden.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <200309140328.54920.folkert@vanheusden.com>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2003 at 03:28:54AM +0200, Folkert van Heusden wrote:
> I found this patch for kernel 2.2 which logs a message when some process=
=20
> receives SIGSEGV. Imho something very usefull: I could create some script=
=20
> which sends an e-mail if some critical (apache, mysql, etc.) process=20
> segfaults. I was wondering: has anyone ported this patch to 2.4 or 2.6?=
=20

What patch?

--=20
Joshua Kwan

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP2PP86OILr94RG8mAQJcuA//UPtqtH+5Up+OxylpLfcwvxnc9uMfeO1p
Gn/1/So8JsD5M0kdZO0BsH+DeOX/6gE/WcJIkQ4mF+nJwje5icBif3TeIkrX5olT
NHbwI3dXBl/bc9NwmCu7wAmhxtkvSXKJdNm/j8KFuF3AtZPDkZ2apHuGH2Eb4IuJ
66TaSaNgs/60y4k770BTox8s8vhJp92iDN13k2xsybO2JAtQXHOBWFkIcecVs7gE
P9UUipvoxAX0Ws6lc1yjZ1vhHdQrelOgHgc2o4KUhZz1ph6B0ERFjo1gWUMtaFSI
zCvG0Hr8Q6bTzXAE19loY/herERW22EJmBa3M4Z9goZafpwUS6v6OMC90QYurPjn
R1dbCsFJEaCe41JdKCiXNQtLQlk3PXwVHNcIsbx4swGEC0kUJHdRRuGuIKg57wxD
vndimnMUVZaC09icfpTfAuZGNz7VuiCH0GKkHr/99Y0nohke8fCw9hLVuHjiUP6S
PYlz9P+t+R0nOUWag69uD0bi20Dc6VlwB0Vc5MXd2UAPbHJZ+/wmUh8mu0CU3hMz
tf7gXRQrZPfoPDO8XWcwN3qsnIyTVGzZHNX/j8eEGgpeCtnF4LgPUnnxcdSPM/pk
FrOYc1AnTsQ+B1fuuwIETYvPz9HhzvAzo+jgYdhvQPWpjBFk54JGF8zNvhSaMqBT
dvmQ+GAKlnQ=
=EWJx
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
