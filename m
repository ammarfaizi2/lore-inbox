Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUFDNli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUFDNli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 09:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUFDNli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 09:41:38 -0400
Received: from vhost-13-248.vhosts.internet1.de ([62.146.13.248]:61398 "EHLO
	spotnic.de") by vger.kernel.org with ESMTP id S263685AbUFDNlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 09:41:36 -0400
In-Reply-To: <20040604095409.GL18885@web1.rockingstone.nl>
References: <20040604075448.GK18885@web1.rockingstone.nl> <200406040943.i549h2aG000175@81-2-122-30.bradfords.org.uk> <20040604095409.GL18885@web1.rockingstone.nl>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-10-675105218"
Message-Id: <E0E7D4BA-B62C-11D8-B781-000A958E35DC@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Daniel Egger <de@axiros.com>
Subject: Re: DriveReady SeekComplete Error
Date: Fri, 4 Jun 2004 15:41:27 +0200
To: Rick Jansen <rick@rockingstone.nl>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-10-675105218
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 04.06.2004, at 11:54, Rick Jansen wrote:

> The output from smartctl -a seems a bit large to include in this email.

This is usually also a bad sign, escpecially if the size is caused
by the Error Log Structure areas.

Please send the info of smartctl -v <device>. This should give a
good indication of whether this is a kernel or a drive problem
because it will show some of the internal status of the drive.

Servus,
       Daniel

--Apple-Mail-10-675105218
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQMB8BzBkNMiD99JrAQJKRwf/dFz2oPy4qU7hKr538haGG+0/dQWybodh
01EmS4k/sgEKfJ7lr9+1mMxqRHv9H3gf5+UOBE1xrOaOXQ1Uhoba38UQ3yWiKNua
hvTscvjNQ6bfBCdNCSAtMhxPCJ7fmvbheSibzoLZOX9dl8FcWLBhGS2tOB2czyfa
TNKpYpfaN8QHzIAS4PMpFdH7TfxPe/SHPJ0QoKKBAe7VF4+4pg6Vc9phXBNVKrPC
wS3SuZU/lUDBEDJEzLu5T+Xwh4/XMO1pcZv2ZmtPchmkHbm/ADlA+DWgwCO3jq/L
m6aZcrM2Rx7Hm37dI/WpHwL+79LcLGsBjZ/o4wls7XYnxnlR0ip19g==
=Rvn5
-----END PGP SIGNATURE-----

--Apple-Mail-10-675105218--

