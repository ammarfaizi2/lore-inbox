Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVFMTt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVFMTt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVFMTt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:49:58 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:56080 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261248AbVFMTtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:49:07 -0400
Message-Id: <200506131948.j5DJmh0j019532@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andi Kleen <ak@muc.de>
Cc: Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2 
In-Reply-To: Your message of "Mon, 13 Jun 2005 20:51:09 +0200."
             <20050613185109.GA86745@muc.de> 
From: Valdis.Kletnieks@vt.edu
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com> <20050613170941.GA1043@in.ibm.com> <m1k6kyb0px.fsf@muc.de> <20050613183716.GH8020@atomide.com>
            <20050613185109.GA86745@muc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118692123_5914P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jun 2005 15:48:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118692123_5914P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Jun 2005 20:51:09 +0200, Andi Kleen said:

> The main issue with HPET is that many BIOS even though the chipsets
> have it don't set up the HPET table because Windows doesn't use
> it right now. However that can be avoided with some chipset
> specific code.

If the Intel 845 chipset in my laptop has an HPET, I'm willing to test code. ;)

--==_Exmh_1118692123_5914P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCreMbcC3lWbTT17ARAkxXAJ91KREZaB0S8VLwtKGUI53ydQqcbgCgoXSl
puf4QuHj5ca3Tj+4kzsopMg=
=ZXOA
-----END PGP SIGNATURE-----

--==_Exmh_1118692123_5914P--
