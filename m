Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTJDNwK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 09:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbTJDNwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 09:52:10 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:6624 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262040AbTJDNwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 09:52:04 -0400
Date: Sat, 4 Oct 2003 10:52:27 -0400
From: Rhino <rhino9@terra.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6-mm3
Message-Id: <20031004105227.7e63240c.rhino9@terra.com.br>
In-Reply-To: <20031004021255.3fefbacb.akpm@osdl.org>
References: <20031004021255.3fefbacb.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__4_Oct_2003_10_52_27_-0400_hTMopzA0BDWr0pvf"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__4_Oct_2003_10_52_27_-0400_hTMopzA0BDWr0pvf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 4 Oct 2003 02:12:55 -0700
Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm3/
> 
> . Added the Intel MSI interrupt patch.  This is mainly to get it under
>   test and under review and to provide the Intel developers with a codebase
>   against which to continue working.  Probably nobody has the hardware yet.
> 
> . Added the Intel EFI patch for the same reason.  Don't enable
>   CONFIG_ACPI_EFI on ia32: you will lose your PCI busses.
> 
> . Placed the must-fix and should-fix lists into Documentation/.  This is
>   for people to review and to hopefully raise patches against.
> 
> . Plus the usual bunch of random fixes.
> 

got these endless messages :

pid 4220 pgrp 4220 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4221 pgrp 4220 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4219 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4219 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 3542 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4223 pgrp 4223 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4224 pgrp 4223 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4222 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4222 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 3542 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 3542 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4227 pgrp 4227 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4228 pgrp 4227 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4226 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4226 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 3542 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 4229 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0
pid 3542 pgrp 3542 sid 3542 tty 00000000 ENOTTY vs tty f7984000 sid 0

....

--Signature=_Sat__4_Oct_2003_10_52_27_-0400_hTMopzA0BDWr0pvf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ft6vP7/1py/aJRgRAl19AJsE722AONk/hpxY5o26w1ckUHZTMQCgv+Ip
rUw0SgE4KibHuARxn9zR7QA=
=3p6+
-----END PGP SIGNATURE-----

--Signature=_Sat__4_Oct_2003_10_52_27_-0400_hTMopzA0BDWr0pvf--
