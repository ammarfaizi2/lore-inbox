Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265023AbSKFNEQ>; Wed, 6 Nov 2002 08:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265025AbSKFNEQ>; Wed, 6 Nov 2002 08:04:16 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:56583 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S265023AbSKFNEP>;
	Wed, 6 Nov 2002 08:04:15 -0500
Date: Wed, 6 Nov 2002 14:10:43 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: linux-kernel@vger.kernel.org
Cc: jordan.breeding@attbi.com, Matt_Domsch@Dell.com, rob@osinvestor.com,
       nwourms@netscape.net
Subject: Re: Watchdog drivers
Message-ID: <20021106141043.A29723@medelec.uia.ac.be>
References: <20021014184031.A19866@medelec.uia.ac.be> <Pine.LNX.4.44.0210141408400.13924-100000@humbolt.us.dell.com> <20021015192615.A1512@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021015192615.A1512@medelec.uia.ac.be>; from wim@iguana.be on Tue, Oct 15, 2002 at 07:26:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I updated the watchdog patches for v2.5.45. (To reflect the Kconfig configuration files).
Patch 1 : move of existing watchdog drivers in drivers/char/watchdog/
Patch 2 : remove of 'old' watchdog drivers in drivers/char/
Patch 3 : cleanup additional spaces in headers + addition of MODULE-info
Patch 4 : C99 designated initializers for watchdog drivers
Patch 5 : add extra watchdog drivers
Patch 6 : changes the CONFIG dependencies in wdt_pci.c (They were incorrect).

The patches are ftp-able at:
ftp://medelec.uia.ac.be/pub/linux/kernel-patches/ .
The diff files are wd-2.5.45-patch*

Greetings,
Wim.
