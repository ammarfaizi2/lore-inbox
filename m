Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270921AbTGVPtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 11:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270922AbTGVPtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 11:49:41 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:32899 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S270921AbTGVPtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 11:49:39 -0400
Date: Tue, 22 Jul 2003 18:04:42 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Tom Felker <tcfelker@mtco.com>
Cc: linux-kernel@vger.kernel.org, Simon Kirby <sim@netnation.com>
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
Message-Id: <20030722180442.6c116e1c.martin.zwickel@technotrend.de>
In-Reply-To: <pan.2003.07.22.15.14.44.457281@mtco.com>
References: <bUil.2D8.11@gated-at.bofh.it>
	<pan.2003.07.22.15.14.44.457281@mtco.com>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.3claws36 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Je62u23b0Y_PaY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Je62u23b0Y_PaY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2003 10:14:46 -0500
Tom Felker <tcfelker@mtco.com> bubbled:

> On Tue, 22 Jul 2003 03:40:09 +0200, Simon Kirby wrote:
> > 
> > Is anybody else seeing this or is it something to do with my setup here?
> > 
> > Simon-
> 
> I see this too, on a much faster system.  My browsing habit is to open a
> link in a new tab, and immediately click on that tab.  The mouse gets
> noticeably jumpy right after clicking the link.  I may be jaded by my
> 2.4.20-gentoo kernel which never did this, but still...
> 
> My system is a 2.4 GHz P4 running Gentoo, 2.6.0-test1 (tainted with
> nVidia), and Mozilla Firebird, with a USB mouse.

I have the same problem with 2.6.0-t1-ac2. If I minimize a
window, my xmms hangs for a few ms. Same if I browse on some pages and go
back/forward.
The screen/windows also fills/draws a little bit slow. (well,
could be a X/nvidia problem)

I changed back to 2.4.22-p7 and everything works fine.

Regards,
Martin

ps.:
my machine: P4 2.4Ghz, 512Mb ram, Gentoo, nvidia driver, mozilla 1.4

-- 
MyExcuse:
Power company testing new voltage spike (creation) equipment

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--=.Je62u23b0Y_PaY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/HWCamjLYGS7fcG0RAs1hAJ4klp/VeD1QGeoxlHGrWznEFlp0EACdFmLA
4Yw6aHY1bDlj7p5TYkkgPf0=
=/g/D
-----END PGP SIGNATURE-----

--=.Je62u23b0Y_PaY--
