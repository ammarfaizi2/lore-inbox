Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUEGVKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUEGVKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 17:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUEGVKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 17:10:25 -0400
Received: from vhost-13-248.vhosts.internet1.de ([62.146.13.248]:47001 "EHLO
	spotnic.de") by vger.kernel.org with ESMTP id S263752AbUEGVKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 17:10:22 -0400
In-Reply-To: <540670000.1083946935@[10.10.2.4]>
References: <20040507085312.3247d70d@dell_ss3.pdx.osdl.net> <540670000.1083946935@[10.10.2.4]>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-33-430209947"
Message-Id: <AFF4F99A-A06A-11D8-BC48-000A958E35DC@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
From: Daniel Egger <de@axiros.com>
Subject: Re: Distributions vs kernel development
Date: Fri, 7 May 2004 23:08:28 +0200
To: "Martin J. Bligh" <mbligh@aracnet.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-33-430209947
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 07.05.2004, at 18:22, Martin J. Bligh wrote:

> Testing is very solid too, has 2.6 support out of the box, and more 
> updated
> desktop stuff (I run that on my laptop). Unstable seems more stable 
> than most
> vendors shipped distros to me, but changes more rapidly. They also 
> seem to
> break serial console occasionally in unstable by loading fonts into it
> (idiots!), but that's trivial to fix.

I'm running Debian stable, Debian stable/testing (mix) and Debian 
unstable
with both customized 2.4 and 2.6 as well as stock 2.4 and 2.6 kernels
without any sign of problems. Of course lm-sensors on top of a stock 2.4
kernel will not fly but everything else works quite fine.

I might also add that I can test quite a few combinations because many
of my machines are netbooting and thus picking up a different version
is a easy as relinking a directory and this always needs a selfcompiled
kernel because of the nfsroot and ip autoconfiguration settings. The
downside is that I needed to make slight modifications to the systems
to have partly separated temp dirs without the need for one complete
installation per machine.

Servus,
       Daniel

--Apple-Mail-33-430209947
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQJv6zDBkNMiD99JrAQLomggAsBuI8XZcbLCwXzVWkT6+BSjv7fa3dTHK
I2xhWY4KXNbm3cU+y/9n+9E1JR4hsp0AofqzYVyK6bSML0Boj6Islr5CGWC26jCm
Sh3vHNVTBCLzPWxHnLJlAbTI0Lk5AGK+89PcUX0mSJgHVZNIYQq9p2Rmo93FrUvR
gHXN+ayAYfvLmzMfKKWW4iCf8qhcHAwSpb8RMZuuBKVR9hNyFFHieONM89CTvrdf
VpOLQRRo2p0AqJpbwJuz4+vYQBckXhGwX0Rm2mi93S+z8V7pj1k43tKanQuodhz5
+c2i8cAKkN/8KQ0JlHwH9Qe16KTGjGFLucGKvTvMNTrSjZ5fdyxL0w==
=IPjV
-----END PGP SIGNATURE-----

--Apple-Mail-33-430209947--

