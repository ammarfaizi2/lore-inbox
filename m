Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288058AbSCGA42>; Wed, 6 Mar 2002 19:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSCGA4S>; Wed, 6 Mar 2002 19:56:18 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:11904
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S288058AbSCGA4A>; Wed, 6 Mar 2002 19:56:00 -0500
Date: Wed, 6 Mar 2002 16:55:49 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Linux 2.5.5-dj3 - modprobe psmouse
In-Reply-To: <20020306124741.J6531@suse.de>
Message-ID: <Pine.LNX.4.33.0203061653060.2886-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Another one...

modprobe psmouse

doesn't trigger a modprobe of i8042

I don't know if you think this should happen in kernel code, or if it
should be in modules.conf...

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8hrqasYXoezDwaVARAmyHAJ0Q5RExa2EGRWTsHo7mt2ZjMVOGqgCcCfwW
B+sskq3bq9/Bmp8FhzlvWm4=
=JAV+
-----END PGP SIGNATURE-----

