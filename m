Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbVISVFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbVISVFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbVISVFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:05:18 -0400
Received: from main.gmane.org ([80.91.229.2]:8882 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932687AbVISVFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:05:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: PWC 10.x driver in the kernel?
Date: Mon, 19 Sep 2005 14:01:41 -0700
Message-ID: <dgn8vo$oli$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA5C19E47E03970AA7FE0405A"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: lal-99-128.reshall.berkeley.edu
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA5C19E47E03970AA7FE0405A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I've just acquired a Logitech webcam and I couldn't get it to work with
the version of the PWC driver currently in the kernel. Given all the
contention about PWCX etc., are there plans to merge in the new 10.x
version of the driver available at http://www.saillard.org/linux/pwc/?
(This version does work with my webcam.) Just like the one in the kernel
tree right now, this version does not require pwcx at all (the binary
blob was reverse-engineered), so I think it's a big improvement.

Thanks,

-- 
Joshua Kwan

--------------enigA5C19E47E03970AA7FE0405A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQy8nO6OILr94RG8mAQLfdRAAmD0X2Z2rKxFhDhuq6YaJr1R7Va1x1t8B
s58Npg8tP3BZ8Rm43Kx1jnJgYMw6yxVW1D7NcbZy+6iV/JXtxATE9NWjaZ+yHFGV
XI3ZWOD6hTYo4d3anwPbVsAh0LAjfdh9Ky3q81ueA7JMpTvFoLKm82XXmln1taaO
logpf5uOYe8+BULQBmfPFflRGh01gKf/hSaJJk6OTBl4GL4p+LrlgZygCZbyyeWE
mByFLFcfX1MiVNTO1SJUIDuaSjiJJ9HsGP3cQVkCy2z04I3WwG1e+r5BcGjPXZCt
0AY5D4vKgl7RFxEGnVt/TEfIW5RaN9oqsg3G7+GH27JbrcgyCseEL6XTL8bwnOZQ
jakzIrqhUVLUsRJX9uZHox8+1a4wN/cwXxt1DeNjzviK6uMcCYc6kyeq4kPzWEr9
mpeH9rb68FSKXxOdX/nOLf7K+4I8egOCcvAwVLqM9nkgqhqq1g886Fc+/XiAkSaV
wsUBVLDps3NwYx3JTzNv40P8aBQzGy5F3WjsIgwROfKy4It2ZEA6kPFTXWks610X
hlMIHK1Ey6kSFzX+PPmeJczCiexgjAa2T6sGJJlJyG2/EgLe5umo/5GmEAZnzxCi
qo1xmB920ljNKydvwyYmpLYN9w1+3jaVLRkWC8HExmBiHS+twWnrK730ttoDzekR
5FQQYD5qumg=
=wPkw
-----END PGP SIGNATURE-----

--------------enigA5C19E47E03970AA7FE0405A--

