Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVATDSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVATDSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVATDSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:18:16 -0500
Received: from h80ad2608.async.vt.edu ([128.173.38.8]:8467 "EHLO
	h80ad2608.async.vt.edu") by vger.kernel.org with ESMTP
	id S261965AbVATDSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:18:12 -0500
Message-Id: <200501200315.j0K3FWHS006194@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: george@mvista.com
Cc: Andrea Arcangeli <andrea@suse.de>, Tony Lindgren <tony@atomide.com>,
       Pavel Machek <pavel@suse.cz>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch 
In-Reply-To: Your message of "Wed, 19 Jan 2005 14:59:20 PST."
             <41EEE648.2010309@mvista.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050119000556.GB14749@atomide.com> <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com> <20050119174858.GB12647@dualathlon.random>
            <41EEE648.2010309@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106190931_28998P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jan 2005 22:15:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106190931_28998P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jan 2005 14:59:20 PST, George Anzinger said:

> allows the PIT to be the "gold standard" in time that it is designed to be. The 
> wake up interrupt, then needs to come from an independent timer.  My patch 
> requires a local APIC for this.  Patch is available at 
> http://sourceforge.net/projects/high-res-timers/

Foo. and me with a BIOS-borked LAPIC.  Anybody have helpful hints on how to
get Dell to fix a laptop BIOS(*), or are you all too busy dying of hysterical laughter?

Dell Latitude C840, running bios A13 (most recent). I *know* it was borked
around A08, and the bios release notes haven't mentioned fixing it.  I wonder
if it's worth re-checking anyhow....

--==_Exmh_1106190931_28998P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB7yJTcC3lWbTT17ARAu5nAKDL3NczljoEPhdHmfpn/s+6fZMjFwCgs6p3
83Q4llg8VzdpanxG0xaxh+w=
=d9n0
-----END PGP SIGNATURE-----

--==_Exmh_1106190931_28998P--
