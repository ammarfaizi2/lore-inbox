Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268407AbTBSNMA>; Wed, 19 Feb 2003 08:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268457AbTBSNMA>; Wed, 19 Feb 2003 08:12:00 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:45831 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268407AbTBSNL7>; Wed, 19 Feb 2003 08:11:59 -0500
Date: Wed, 19 Feb 2003 14:21:59 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.62]: 1/3: Make Ethernet 1000Mbit also a seperate,
 complete selectable submenu
In-Reply-To: <200302181350.49492.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.44.0302191419460.32518-100000@serv>
References: <200302181350.49492.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Feb 2003, Marc-Christian Petersen wrote:

> so you can disable all 1000Mbit NICs at once.

For a larger group of config options you can also put them between 'if 
NET_ETHERNETGBIT' and 'endif'. It has the same effect.

bye, Roman

