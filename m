Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270985AbTGPS6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270986AbTGPS6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:58:37 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:25728 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270985AbTGPS6d (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:58:33 -0400
Message-Id: <200307161913.h6GJDMup001400@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Cc: Jens Axboe <axboe@suse.de>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session. 
In-Reply-To: Your message of "Wed, 16 Jul 2003 15:03:35 EDT."
             <3F15A187.3090802@enterprise.bidmc.harvard.edu> 
From: Valdis.Kletnieks@vt.edu
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk> <20030716171607.GM833@suse.de> <20030716172331.GD21896@suse.de> <20030716172531.GP833@suse.de> <20030716172823.GE21896@suse.de> <20030716173122.GQ833@suse.de>
            <3F15A187.3090802@enterprise.bidmc.harvard.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-865750884P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Jul 2003 15:13:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-865750884P
Content-Type: text/plain; charset=us-ascii

On Wed, 16 Jul 2003 15:03:35 EDT, "Kristofer T. Karas" said:

> FWIW, this also affects PPP over an async serial line (in my case to a 
> 56Kb modem).  During cdparanoia runs, the modem Tx/Rx lights all but 
> stop as the missed packets drop retransmissions into the minute+ 
> timeframe.  (Oddly, I don't recall seeing framing errors from ifconfig; 
> must be the lower level ppp substrate or some such...)

I remember seeing this in the 2.5.6mumble kernel as well, it got fixed by
something around 2.5.70 or so.  I wish I could give a more specific release
number for it.

--==_Exmh_-865750884P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/FaPRcC3lWbTT17ARAmX4AKCdT3dRVvzFyUUe7xPNJ6hmX4KtqACfamc8
T52L3Z29yfq89GU8FZGx0qI=
=IBL2
-----END PGP SIGNATURE-----

--==_Exmh_-865750884P--
