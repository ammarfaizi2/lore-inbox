Return-Path: <linux-kernel-owner+w=401wt.eu-S1754800AbXABCQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbXABCQa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 21:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754788AbXABCQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 21:16:29 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:44531 "EHLO
	shaft.shaftnet.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800AbXABCQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 21:16:29 -0500
X-Greylist: delayed 2803 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jan 2007 21:16:28 EST
Date: Mon, 1 Jan 2007 20:35:59 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] radeonfb: add support for newer cards
Message-ID: <20070102013559.GA10385@shaftnet.org>
Mail-Followup-To: Luca Tettamanti <kronos.it@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
References: <20070101212551.GA19598@dreamland.darkstar.lan> <20070101214442.GA21950@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20070101214442.GA21950@dreamland.darkstar.lan>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Mon, 01 Jan 2007 20:36:00 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 01, 2007 at 10:44:42PM +0100, Luca Tettamanti wrote:
> And - for an easier review - this is the diff between
> radeonfb-atom-2.6.19-v6a.diff from Solomon and my patch (whitespace-only
> changes not included).

It looks good in this quick once-over..=20

Thanks for the rebase!

Acked-by:  Solomon Peachy <pizza@shaftnet.org>=20

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFmbb/PuLgii2759ARAvXkAJ9RfbqNo3eQc1HNlh1P/sU+fCEDqwCdFG7H
GwjIm9xQbhQ77UNpTWfhINE=
=7LIv
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
