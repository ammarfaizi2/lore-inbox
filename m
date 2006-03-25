Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWCYSvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWCYSvN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWCYSvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:51:09 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:42665 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932235AbWCYSuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:50:39 -0500
Date: Sat, 25 Mar 2006 19:50:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "John Z. Bohach" <jzb@aexorsyst.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: mem= causes oops
In-Reply-To: <200603251036.40379.jzb@aexorsyst.com>
Message-ID: <Pine.LNX.4.61.0603251948360.29793@yvahk01.tjqt.qr>
References: <200603212005.58274.jzb@aexorsyst.com> <200603240936.13178.jzb@aexorsyst.com>
 <20060324163237.5743bd3c.rdunlap@xenotime.net> <200603251036.40379.jzb@aexorsyst.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: Re: mem= causes oops (was Re: BIOS causes (exposes?) modprobe
>    (load_module) kernel oops)
>

Hm, seeing this mail reminds me of something I seen on SPARC just a while 
ago. Maybe it's just something on my side. If I specify `mem=65536`, that 
is, with no size suffix like M or G, what does Linux make out of it? 65536 
KB or 64 KB?


Jan Engelhardt
-- 
