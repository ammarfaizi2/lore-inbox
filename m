Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbUACXha (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 18:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbUACXh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 18:37:29 -0500
Received: from luli.rootdir.de ([213.133.108.222]:16281 "EHLO luli.rootdir.de")
	by vger.kernel.org with ESMTP id S264319AbUACXh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 18:37:28 -0500
X-Qmail-Scanner-Mail-From: claas@rootdir.de via luli
X-Qmail-Scanner: 1.20 (Clear:RC:1(217.186.136.236):SA:0(-4.4/5.0):. Processed in 0.151707 secs)
Date: Sun, 4 Jan 2004 00:37:28 +0100
From: Claas Langbehn <claas@rootdir.de>
To: =?iso-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: atyfb broken
Message-ID: <20040103233728.GA22427@rootdir.de>
References: <Pine.GSO.4.58.0401021341010.3062@waterleaf.sonytel.be> <Pine.LNX.4.44.0401021621160.15125-100000@deadlock.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401021621160.15125-100000@deadlock.et.tudelft.nl>
Reply-By: Mi Jan  7 00:31:17 CET 2004
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0 i686
X-No-archive: yes
X-Uptime: 00:31:17 up 11:19,  4 users,  load average: 0.10, 0.18, 0.17
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


> > Does it work with 2.4.22 and earlier? Mobility support was changed a lot in
> > 2.4.23.

No, 2.4.22 does not work either. It has also screen-flickering.

2.6.0 seems to be closest to a working solution.

( CONFIG_FB_ATY, CONFIG_FB_ATY_CT and CONFIG_FB_ATY_XL_INIT switched on,
CONFIG_FRAMEBUFFER_CONSOLE disabled)


bye, claas
