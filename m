Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbTBBHFT>; Sun, 2 Feb 2003 02:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbTBBHFT>; Sun, 2 Feb 2003 02:05:19 -0500
Received: from ns3310.ovh.net ([213.186.37.170]:63493 "EHLO ns3310.ovh.net")
	by vger.kernel.org with ESMTP id <S265130AbTBBHFS>;
	Sun, 2 Feb 2003 02:05:18 -0500
Date: Sun, 2 Feb 2003 01:12:57 -0500
From: leonard <leonard@internetdown.org>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MenuConfig 2.4.20 does n0t show all drivers (ACPI, SONYPI, UDF_RW) + MAINTAINERS
Message-Id: <20030202011257.33df8750.leonard@internetdown.org>
In-Reply-To: <20030202070916.GH743@zip.com.au>
References: <20030202005819.605e17f2.leonard@internetdown.org>
	<20030202070916.GH743@zip.com.au>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; Gurney Halleck: The slow blade penetrates the shield)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > Eventough the drivers are provided in the source tree,
> > some options are missing (?!) in the 'make menuconfig'
> > of the linux 2.4.20 kernel.
> > 
> > Thoses I found missing are the drivers for : ACPI, SONYPI, UDF_RW.
> 
> Just a stab in the dark but, have you tried turning on the experimental
> features option? (from memory it's in the first menu).

You're right, they do appear after turning on the experimental features.
It's surprising as ACPI, for example, is not labeled as "experimental"...

Thank you anyway, you guys are doing a great job :)
(Thanks also for the eepro100 -alternative- driver)

G.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+PLbpoqOw021SWZYRAvBxAJ4xekcyoEmHE4Tgxgp4RZK2A1mPDACeJAxX
aQBSCW/L91IaTtBDquqdqCs=
=GyKu
-----END PGP SIGNATURE-----
