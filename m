Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWCZRjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWCZRjP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWCZRjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:39:15 -0500
Received: from xenotime.net ([66.160.160.81]:1226 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751324AbWCZRjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:39:15 -0500
Date: Sun, 26 Mar 2006 09:41:21 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: jzb@aexorsyst.com, linux-kernel@vger.kernel.org
Subject: Re: mem= causes oops
Message-Id: <20060326094121.9464762a.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0603251948360.29793@yvahk01.tjqt.qr>
References: <200603212005.58274.jzb@aexorsyst.com>
	<200603240936.13178.jzb@aexorsyst.com>
	<20060324163237.5743bd3c.rdunlap@xenotime.net>
	<200603251036.40379.jzb@aexorsyst.com>
	<Pine.LNX.4.61.0603251948360.29793@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2006 19:50:35 +0100 (MET) Jan Engelhardt wrote:

> 
> >Subject: Re: mem= causes oops (was Re: BIOS causes (exposes?) modprobe
> >    (load_module) kernel oops)
> >
> 
> Hm, seeing this mail reminds me of something I seen on SPARC just a while 
> ago. Maybe it's just something on my side. If I specify `mem=65536`, that 
> is, with no size suffix like M or G, what does Linux make out of it? 65536 
> KB or 64 KB?

65536 bytes.  All of the suffixes [KMG] are optional.

---
~Randy
