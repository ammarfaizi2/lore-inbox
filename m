Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUFDJDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUFDJDD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUFDJDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:03:03 -0400
Received: from vhost-13-248.vhosts.internet1.de ([62.146.13.248]:19410 "EHLO
	spotnic.de") by vger.kernel.org with ESMTP id S263614AbUFDJDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:03:00 -0400
In-Reply-To: <20040604075448.GK18885@web1.rockingstone.nl>
References: <20040604075448.GK18885@web1.rockingstone.nl>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-658383157"
Message-Id: <F1C736B7-B605-11D8-B781-000A958E35DC@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Daniel Egger <de@axiros.com>
Subject: Re: DriveReady SeekComplete Error
Date: Fri, 4 Jun 2004 11:02:45 +0200
To: Rick Jansen <rick@rockingstone.nl>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1-658383157
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 04.06.2004, at 09:54, Rick Jansen wrote:

> Is this drive fubar? It's installed brand-new, and after only three 
> days
> of operating it's giving me these errors from time to time.

Seems so, try getting the SMART utils and have a look at the
output of smartctl -a <device>.

However I fail to see why this l-k related and as such offtopic
here.

Servus,
       Daniel

--Apple-Mail-1-658383157
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQMA6uzBkNMiD99JrAQIJTggAvgNaCmP7s8vNH6g24OtH3StLjSoxuzpB
RboN3wCbKFQwVSs5ttgv7eQujDmf908eNu0YNGRglsBDqLNBzoNREIpEjaQ9Cvxl
ArSvKCgrnnC0w9DdAjeYNOFtlNTxvzI+xJNXvEGysSw2C1t3fehar3wKjDVPRlbC
zk9zQISICywq3UX8VWbKSLU2kWcGBSIcJBMwoOLprEPlHfXbgPFR8BZCVgRdw78Q
IL/NT3FRM7J3NeJE3pbg7cBGSe/qfNI2knRvZSU6Q8NSc6g+LtFbZCXVnMyb7rG9
EoRJelk+rZn8OhF/xjxO5thkxmUULbbpexJH6FmBd2FhuvR2IYG45g==
=CMTT
-----END PGP SIGNATURE-----

--Apple-Mail-1-658383157--

