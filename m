Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270377AbTGNLnA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270403AbTGNLm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:42:59 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:9615 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S270377AbTGNLm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:42:57 -0400
Date: Mon, 14 Jul 2003 13:57:41 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Paul Nasrat <pauln@truemesh.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: Hang during boot on Intel D865PERL motherboard
Message-Id: <20030714135741.5a12c14f.martin.zwickel@technotrend.de>
In-Reply-To: <20030714110335.GQ28359@raq465.uk2net.com>
References: <20030714110311.6059.qmail@linuxmail.org>
	<20030714110335.GQ28359@raq465.uk2net.com>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.0claws93 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.URqUnxAt8:L6s?"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.URqUnxAt8:L6s?
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2003 12:03:35 +0100
Paul Nasrat <pauln@truemesh.com> bubbled:

> On Mon, Jul 14, 2003 at 12:03:11PM +0100, Felipe Alfaro Solana wrote:
> > Hi,
> > 
> > I've compiled linux-2.6.0-test1 kernel with the attached "config" file. When
> > trying to boot the kernel, it hangs on "Uncompress Linux kernel...OK". The
> > system is:
> 
> You only have the dummy console selected ensuring you have:
> 
> CONFIG_CONSOLE_VGA=y

you meant:
CONFIG_VGA_CONSOLE=y

> 
> Should display things to screen.
> 
> Paul
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
MyExcuse:
tachyon emissions overloading the system

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--=.URqUnxAt8:L6s?
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Epq1mjLYGS7fcG0RAplVAJ9FzJXaAzrGDSdqzqoaRpRGTGKSGwCeKZb4
uFkjWWYn7qAyvTJfNlinGJ0=
=ZR/q
-----END PGP SIGNATURE-----

--=.URqUnxAt8:L6s?--
