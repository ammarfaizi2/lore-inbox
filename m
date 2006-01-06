Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWAFMxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWAFMxR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWAFMxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:53:17 -0500
Received: from sipsolutions.net ([66.160.135.76]:7942 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1751451AbWAFMxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:53:16 -0500
Subject: Re: State of the Union: Wireless
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Rompf <stefan@loplof.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601061348.05803.stefan@loplof.de>
References: <20060106042218.GA18974@havoc.gtf.org>
	 <1136547084.4037.41.camel@localhost>
	 <20060106114620.GA23707@isilmar.linta.de>
	 <200601061348.05803.stefan@loplof.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JjMFrYfxIAVb9C+yocDS"
Date: Fri, 06 Jan 2006 13:53:06 +0100
Message-Id: <1136551986.4037.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JjMFrYfxIAVb9C+yocDS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-01-06 at 13:48 +0100, Stefan Rompf wrote:

> With hardware like prism2 usb that gets "don't touch me now mode" for a w=
hile=20
> after a join command is issued, current API requires a driver to delay=20
> starting an association in order to wait if other config requests are iss=
ued=20
> - an ugly hack.

So that settles the 'need to change multiple settings at once' issue,
saying that yes, it is indeed required.

johannes

--=-JjMFrYfxIAVb9C+yocDS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ75oL6Vg1VMiehFYAQIQFg//dI++Tp9Fm9PS48Gruho2OzooIARV/1qm
WQv3DwamQympGHbJ8xAVvI+9U1T/G+Adyq+MqKc2sHoRt/TBEA5oV2JWVYJIRfI2
O5TQaV2/Zd3CKYZKzipqgthkDl22U0qfBUE4w4xClk+7xfDCKazPTPXPUYtuvJEQ
ocI6YqVj3T0R2ef+wDnzIMilvDCWGJJYL2tl6mosQ3FhZzfzWpyhhkn1Fx1Iw7Ax
eM0VwQoPl8gLgbyior5ojSprlDPMRdZOcp5Qd5NCPYUv+aLkvrDTlPXd2TPcxKJN
yitoVwGOEpl9sngcKHAms2jOZCHW5zJwQcE18KiF55Cn/yV6P1VZpD3mpS5c9Nbw
QheyQai/xw4SNjiL++YnzD5PHl15Ip1SJynbz+W7OajcYx69j3rb66gSU42TORVd
jhQuMRZascb8vAcJZO5osahapcXfqZt+fcEl3lziUfY95xTVMERygceFJtedTgKR
bQGrkdyORL1MUgIGx/CGKLpAzJLWMk8+XmD+Vb2/dzV/9jJsEHU7aaI3omi894jR
CFD/Jrk0IxMfScHQGilbVTwcR6fh55rqDwsny5vh7KQxApi318rWzLzmCxN90Y2f
M8Hh+w8Me1Ks3rNrROo/MtduGj3+2FDU9YZ2EkkpU7OiZ7bf7YYqJyCppk1DzAXx
ipDKGxx+lyw=
=K99s
-----END PGP SIGNATURE-----

--=-JjMFrYfxIAVb9C+yocDS--

