Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965243AbWBIRRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965243AbWBIRRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbWBIRRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:17:34 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44950 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965243AbWBIRRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:17:33 -0500
Date: Thu, 9 Feb 2006 18:17:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthew Garrett <mjg59@srcf.ucam.org>
cc: Pavel Machek <pavel@ucw.cz>, john@neggie.net, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Add generic backlight support to toshiba_acpi driver
In-Reply-To: <20060209165407.GA20754@srcf.ucam.org>
Message-ID: <Pine.LNX.4.61.0602091815390.30108@yvahk01.tjqt.qr>
References: <20060207133456.GA2452@srcf.ucam.org> <20060208090757.GB11895@elf.ucw.cz>
 <Pine.LNX.4.61.0602091747070.30108@yvahk01.tjqt.qr> <20060209165407.GA20754@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> Note to self: Don't forget to change 2.6-sony-acpi?.diff from -mm to use 
>> this /sys/class/backlight instead of /proc/acpi/sony/brightness when it's 
>> ready.
>
>Ah, you're maintaining that now. Here you go (Stelian took a look and 
>seemed happy with it - the /sys/class/backlight stuff is in mainstream)
>
Well, I am not. At least not-yet-officially. But since I happen to have 
that hardware, I use it. (And I even have to postpatch the SUSE KOTD ATM
to get there, heh, heh.)



Jan Engelhardt
-- 
