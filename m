Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUABP1w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 10:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265535AbUABP1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 10:27:52 -0500
Received: from smtp.terra.es ([213.4.129.129]:29438 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S261506AbUABP1v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 10:27:51 -0500
Date: Fri, 2 Jan 2004 16:27:24 +0100
From: Diego Calleja <grundig@teleline.es>
To: DXpublica@telefonica.net
Cc: john@grabjohn.com, ms@citd.de, linux-kernel@vger.kernel.org
Subject: Re: i18n for kernel 2.7.x?
Message-Id: <20040102162724.542f32ea.grundig@teleline.es>
In-Reply-To: <200401020153.59030.DXpublica@telefonica.net>
References: <200312311332.15422.DXpublica@telefonica.net>
	<200312311625.25178.DXpublica@telefonica.net>
	<200312311604.hBVG4ruS000274@81-2-122-30.bradfords.org.uk>
	<200401020153.59030.DXpublica@telefonica.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 2 Jan 2004 01:53:58 +0100 Xan <DXpublica@telefonica.net> escribió:

> 
> Well... if (all of) you think that.... 
> But, what happens with Documentation/ directory and README, COPYRIGHT, ... and 
> WEB PAGE of the kernel?
> 
> It's NOT so technically hard to do. Why not so?

People are already doing this for the help entries of the configure process:
http://es.tldp.org/NuLies/web/index.html (in Spanish). This is just a patch
over the kernel. The 2.6 split of the configure files will help to coordinate
the efforts, it'd not be very difficult to include it as a "extra" package
in normal distributions. It's not complete of course...


