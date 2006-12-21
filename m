Return-Path: <linux-kernel-owner+w=401wt.eu-S1422773AbWLUPmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWLUPmc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 10:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422868AbWLUPmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 10:42:32 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43311 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422773AbWLUPmc (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 10:42:32 -0500
Message-Id: <200612211542.kBLFgECL013303@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu
Subject: Re: [PATCH -mm 0/5][time][x86_64] GENERIC_TIME patchset for x86_64
In-Reply-To: Your message of "Wed, 20 Dec 2006 17:13:19 EST."
             <20061220220945.15178.2669.sendpatchset@localhost>
From: Valdis.Kletnieks@vt.edu
References: <20061220220945.15178.2669.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1166715734_12674P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Dec 2006 10:42:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1166715734_12674P
Content-Type: text/plain; charset=us-ascii

On Wed, 20 Dec 2006 17:13:19 EST, john stultz said:
> Andrew, Andi,
> 
> Here is the same patchset from lastnight, re-diffed against -mm

This one does indeed apply, compile, and boot.

> Thanks to Valdis Kletnieks for pointing out that it didn't apply.

Not being a locking ninja or a PCI demigod, I figure I can at least contribute
testing and mostly-parseable bug reports. :)

--==_Exmh_1166715734_12674P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFiqtWcC3lWbTT17ARAvkSAKCOZH/wGd93Wugo5uUYyHfZkYESNQCbBGHX
DtWPN+ClRi8SGpuRxOzMDiQ=
=K8Oq
-----END PGP SIGNATURE-----

--==_Exmh_1166715734_12674P--
