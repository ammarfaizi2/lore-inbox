Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVEIVHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVEIVHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 17:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVEIVHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 17:07:34 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:11273 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261524AbVEIVH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 17:07:27 -0400
Message-Id: <200505092107.j49L7J7C028882@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: KC <kcc1967@gmail.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: proc_mknod() replacement 
In-Reply-To: Your message of "Tue, 10 May 2005 01:06:08 +0800."
             <5eb4b065050509100638bd7970@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <5eb4b06505050904172655477c@mail.gmail.com> <20050509154147.GC5799@harddisk-recovery.com>
            <5eb4b065050509100638bd7970@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115672835_6742P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 09 May 2005 17:07:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115672835_6742P
Content-Type: text/plain; charset=us-ascii

On Tue, 10 May 2005 01:06:08 +0800, KC said:

> Why I want to use proc_mknod() in driver ?  I write a small package, ovi-dev,
> which can be downloaded from
> http://www.sourceforge.net/projects/ovi
> The ovi-dev will scan the PCI bus and if it found, eg, 3 PCI devices, it
> will create 3 device entries (nodes) automatically at module load time.
> So number of device entries (nodes) will match number of devices
> of the system ... well, UNIX/Linux doesn't work that way ... there are a lot
> of device entries ... but no corresponding hardware existed.

Congrats.  You've re-invented udev.



--==_Exmh_1115672835_6742P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCf9EDcC3lWbTT17ARArMPAJ0YYmrvwJ9jicTQb6hAcV0piZhR4gCeL1ro
nT6fb+dsA6bLk4+DP71PraQ=
=2pNL
-----END PGP SIGNATURE-----

--==_Exmh_1115672835_6742P--
