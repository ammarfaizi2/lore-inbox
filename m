Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264302AbUE2PaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264302AbUE2PaX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 11:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbUE2PaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 11:30:23 -0400
Received: from dialin-212-144-165-116.arcor-ip.net ([212.144.165.116]:23691
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S264302AbUE2PaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 11:30:21 -0400
In-Reply-To: <20040528163234.GV2603@schnapps.adilger.int>
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net> <200405280941.38784.m.watts@eris.qinetiq.com> <20040528062141.GA18118@cox.net> <20040528150119.GE18449@thunk.org> <20040528163234.GV2603@schnapps.adilger.int>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-7-163235137"
Message-Id: <168FA640-B185-11D8-9291-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: ftp.kernel.org
Date: Sat, 29 May 2004 17:30:17 +0200
To: Andreas Dilger <adilger@clusterfs.com>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-7-163235137
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 28.05.2004, at 18:32, Andreas Dilger wrote:

> Ideally we would move to something like http/ftp-meets-bittorrent for 
> content
> replication.  Then sites which are popular would have lots of mirrors 
> by
> default, and dedicated FTP mirror sites would actually share bandwidth 
> ala
> bittorrent instead of just having copies of the same data.  If this 
> started
> using users' web browser cache as bittorrent mirrors it would be 
> totally
> impossible to slashdot a site.

Actually I think this is *the* idea. Why not simply set up a
bittorrent tracker and have a distributed kernel.org
fileserving system? Instead of having links to http and ftp
sites there could be a torrent link as well. Several
OpenSource projects started distributing files with BT
already and it seems to work like a charm.

Servus,
       Daniel

--Apple-Mail-7-163235137
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQLisiTBkNMiD99JrAQI9egf9EhwwZDTjSxRDWeBkBhFUUn/pU1zdIt6k
vBw0Xs/X9hnWnjH/tzQiWbqbvJUn+IZiXBeE+79lKMvfjeccOXOcaytKfpwdDm6R
Ma4MVQRMfY3jjgbc3b7HVQhmlmS2XONnJI/DFT+n79TR6BnWk7TfUjk+1yG0Rpac
x4UTYyZbcwVyP12HvM+SIdbwYv1nH5umpf9OTIlYgVHg5Z2sIryTGhzxAHjpblG2
7puNlOrQyiLzyYuqGuv7y5o+LAhHnssIl2hEzQMsrml/OT2LKRf3F3x0HXWMnJOM
WuigchtB9MAXz4NynfEWjWPbmMBw7JK7JHiB0eyf0i72sf+AVW56JQ==
=d798
-----END PGP SIGNATURE-----

--Apple-Mail-7-163235137--

