Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266584AbUBQVN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266632AbUBQVNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:13:21 -0500
Received: from ln33.neoplus.adsl.tpnet.pl ([83.30.25.33]:28297 "EHLO
	uran.kolkowski.no-ip.org") by vger.kernel.org with ESMTP
	id S266626AbUBQVLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:11:45 -0500
Date: Tue, 17 Feb 2004 22:11:20 +0100
From: Damian Kolkowski <damian@kolkowski.no-ip.org>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org,
       Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
Subject: Re: Radeonfb problem
Message-ID: <20040217211120.ALLYOURBASEAREBELONGTOUS.A8392@kolkowski.no-ip.org>
Mail-Followup-To: Kronos <kronos@kronoz.cjb.net>,
	linux-kernel@vger.kernel.org,
	Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
References: <200402172008.39887.vergata@stud.fbi.fh-darmstadt.de> <20040217203604.GA19110@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040217203604.GA19110@dreamland.darkstar.lan>
X-GPG-Key: 0xB2C5DE03 (http://kolkowski.no-ip.org/damian.asc x-hkp://wwwkeys.eu.pgp.net)
X-Girl: 1 will be enough!
X-Age: 24 (1980.09.27 - libra)
X-IM: JID:damian@kolkowski.no-ip.org ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.4.25-rc3, up  7:21
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kronos <kronos@kronoz.cjb.net> [2004-02-17 21:53]:
> Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de> ha scritto:
> > I'v 2.6.3-rc3-mm1 up and running on an t40p.
> > ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 02)
> > The problem i observe was that reset won't clean my display just draw the new 
> > commandline on the upper left. The screen still old display. 
> 
> Are you running X? This is a known problem, it's X fiddling with accel
> registers. BenH is working on a fix, for now you can boot with "noaccel"
> to disable hw acceleration.
> 
> Btw, how does 2.6.3-rc4 work?

2.6.3-rc4 with new radeonfb looks better, but in lilo.con append for radeonfb
wont work.

P.S. I have rv250if.

-- 
# Damian *dEiMoS* Ko³kowski # http://kolkowski.no-ip.org/ #
