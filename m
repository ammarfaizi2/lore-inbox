Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTKTMlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 07:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTKTMlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 07:41:10 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:30344 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261680AbTKTMlI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 07:41:08 -0500
Date: Thu, 20 Nov 2003 13:41:21 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: wli@holomorphy.com, jgarzik@pobox.com, jt@hpl.hp.com,
       linux-kernel@vger.kernel.org, pof@users.sourceforge.net
Subject: Re: Announce: ndiswrapper
Message-Id: <20031120134121.02e11aff.aradorlinux@yahoo.es>
In-Reply-To: <3FBC4A42.8010806@cyberone.com.au>
References: <20031120031137.GA8465@bougret.hpl.hp.com>
	<3FBC3483.4060706@pobox.com>
	<20031120040034.GF19856@holomorphy.com>
	<3FBC402E.6070109@cyberone.com.au>
	<20031120043848.GG19856@holomorphy.com>
	<3FBC4A42.8010806@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 20 Nov 2003 15:59:46 +1100 Nick Piggin <piggin@cyberone.com.au> escribió:

> I must say that I've been using the same nvidia drivers on my desktop
> system for maybe a year, and never had a crash including going through
> countless versions of 2.5/6. True you need to recompile the intermediate

You're lucky.
Nvidia drivers are broken, and it's not just linux. Their windows drivers
are know to be buggy, too. And this is happening in windows (which has a
"windows driver model" abi which doesn't change even between W9x and nt)

Also, they don't support non-x86 architectures in linux (they have drivers
for mac os X though)
If there're a lot of binary drivers for linux, we'll have the same hell
microsoft has (w2k and XP are rock solid, until you start using crappy
drivers, then everybody complains about blue screens). A stable and defined
abi (like their driver model) doesn't work for them, it won't work for us. 

I don't mind running propietary code...but not in the kernel.

(BTW, are there modern graphics cards with 100% opensource drivers?)


