Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbUAFBCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbUAFBCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:02:15 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52610 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266027AbUAFBCE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:02:04 -0500
Message-Id: <200401060101.i0611qGl012588@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com
Subject: Re: ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2 
In-Reply-To: Your message of "Mon, 05 Jan 2004 17:51:33 MST."
             <1073350293.2802.36.camel@mentor.gurulabs.com> 
From: Valdis.Kletnieks@vt.edu
References: <1073350293.2802.36.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1977675352P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jan 2004 20:01:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1977675352P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Jan 2004 17:51:33 MST, Dax Kelson said:

> Found at boot: 
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: Battery Slot [BAT1] (battery present)
> 
> But no run-time information:
> 
> $ cat /proc/acpi/battery/BAT0/info
> present:                 yes
> design capacity:         0 mWh

Glad to see I'm not crazy.. :)

--==_Exmh_-1977675352P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+gkAcC3lWbTT17ARAtRrAKDe8bLbvL7shg3kdh5+8GosStV6+gCdEuxQ
XianX50qPiV2WyPtK0N7MfU=
=NSTf
-----END PGP SIGNATURE-----

--==_Exmh_-1977675352P--
