Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318388AbSGaWH0>; Wed, 31 Jul 2002 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318390AbSGaWH0>; Wed, 31 Jul 2002 18:07:26 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20235 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318388AbSGaWHY>; Wed, 31 Jul 2002 18:07:24 -0400
Date: Wed, 31 Jul 2002 18:20:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.19-rc4
Message-ID: <Pine.LNX.4.44.0207311819060.1026-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Since some critical problems appeared (mainly the d_unhash() SMP race)
here is rc4.


Summary of changes from v2.4.19-rc3 to v2.4.19-rc4
============================================

<viro@math.psu.edu> (02/07/22 1.648)
	[PATCH] SMP race in d_unhash()

<hch@lst.de> (02/07/22 1.649)
	[PATCH] fix drivers/net/Config.in in 2.4.19-rc3

<kaos@ocs.com.au> (02/07/22 1.650)
	[PATCH] 2.4.19-rc3 include/linux/module.h

<jaharkes@cs.cmu.edu> (02/07/23 1.651)
	[PATCH] 2.4.19-rc3 - Coda

<kaos@ocs.com.au> (02/07/23 1.652)
	[PATCH] 2.4.19-rc3 remove dead variable CONFIG_DRM_AGP.

<marcelo@plucky.distro.conectiva> (02/07/23 1.653)
	Changed EXTRAVERSION to -rc4

<marcelo@plucky.distro.conectiva> (02/07/26 1.654)
	Make FastTrak be disabled by default

<bcollins@debian.org> (02/07/26 1.655)
	[PATCH] Re: [PATCH] Fixes to linux1394

<geert@linux-m68k.org> (02/07/29 1.656)
	[PATCH] penguin logo code

<Lionel.Bouton@inet6.fr> (02/07/30 1.657)
	[PATCH] Remove support to some SiS IDE chipsets which were causing data corruption

<alan@lxorguk.ukuu.org.uk> (02/07/30 1.658)
	[PATCH] Synchronize with a few left overs needed from -ac

<alan@lxorguk.ukuu.org.uk> (02/07/30 1.659)
	[PATCH] More -ac merge

<jgarzik@tout.normnet.org> (02/07/31 1.654.1.1)
	alpha pid-reporting POSIX comformance bug fix:

<davem@redhat.com> (02/07/31 1.661)
	[PATCH] Add missing check to openprom driver

