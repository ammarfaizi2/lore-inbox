Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291251AbSBXVD1>; Sun, 24 Feb 2002 16:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291254AbSBXVDS>; Sun, 24 Feb 2002 16:03:18 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:3456
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S291251AbSBXVDN>; Sun, 24 Feb 2002 16:03:13 -0500
Date: Sun, 24 Feb 2002 13:02:57 -0800 (PST)
From: Ben Clifford <benc@linux.ucla.edu>
To: Dave Jones <davej@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.5-dj1 - IPv6 not loading correctly.
In-Reply-To: <20020222022149.N5583@suse.de>
Message-ID: <Pine.LNX.4.33.0202241300100.11220-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've just moved from 2.5.3 to 2.5.5-dj1

I have ipv6 compiled as a module.

When ipv6.o is loaded, I get:

IPv6 v0.8 for NET4.0
Failed to initialize the ICMP6 control socket (err -97)

and lsmod shows:
ipv6    147968    -1 (uninitialized)

Other than my ipv6 services not starting up, it doesn't seem to cause any
other problems.

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Job Required in Los Angeles - Will do most things unix or IP for money.
http://www.hawaga.org.uk/resume/resume001.pdf
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8eVUHsYXoezDwaVARAuNEAJ9U9Fj1UlMhk/2h82vwcu8KY6/XAACdFAfz
xxsU4t5kJGiOCqtwqZR3WVw=
=CXmF
-----END PGP SIGNATURE-----

