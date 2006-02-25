Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWBYOW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWBYOW7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 09:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160999AbWBYOW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 09:22:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15318 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1160997AbWBYOW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 09:22:59 -0500
Date: Sat, 25 Feb 2006 15:22:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Samuel Masham <samuel.masham@gmail.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
In-Reply-To: <20060225124606.GI3674@stusta.de>
Message-ID: <Pine.LNX.4.61.0602251521300.31692@yvahk01.tjqt.qr>
References: <20060214152218.GI10701@stusta.de> <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr>
 <20060214182238.GB3513@stusta.de> <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr>
 <20060217163802.GI4422@stusta.de> <93564eb70602191933x2a20ce0m@mail.gmail.com>
 <20060220132832.GF4971@stusta.de> <20060222013410.GH20204@MAIL.13thfloor.at>
 <20060222023121.GB4661@stusta.de> <Pine.LNX.4.62.0602251255110.18095@pademelon.sonytel.be>
 <20060225124606.GI3674@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>My 50 MB number was much too high (I didn't want to think where exactly 
>to set the borderline).
>
>My point is that if you are in an environment that is that space limited 
>that you want to see options that allow e.g. not building futexes, 
>module support with an impact of approx. 10% on code size would be one 
>of the first things you should disable.
>

You said that INPUT was not a driver, right. But without it, a keyboard 
won't work, will it?



Jan Engelhardt
-- 
