Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWIEGMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWIEGMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 02:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWIEGMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 02:12:20 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:59868 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965172AbWIEGMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 02:12:18 -0400
Date: Tue, 5 Sep 2006 08:10:23 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       ACPI mailing list <linux-acpi@vger.kernel.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: x60 - spontaneous thermal shutdown
In-Reply-To: <20060904223520.GB1958@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0609050808570.17126@yvahk01.tjqt.qr>
References: <20060904214059.GA1702@elf.ucw.cz> <20060904222614.GA1614@rhlx01.fht-esslingen.de>
 <20060904223520.GB1958@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > Sep  4 23:33:01 amd kernel: ACPI: Critical trip point
>> > Sep  4 23:33:01 amd kernel: Critical temperature reached (128 C), shutting down.
>> > Sep  4 23:33:01 amd shutdown[32585]: shutting down for system halt
>> > Sep  4 23:34:42 amd init: Switching to runlevel: 0
>> > 
>> > I do not think cpu reached 128C, as I still have my machine... Did
>> > anyone else see that?
>> 
>> Could this be in any way related to the (in)famous Random Shutdown issues
>> on a little too many Apple MacBooks?
>> (since the x60 incidentally just happens to be Core Duo
>> architecture, too)
>
>Well, but those macbooks were really overheating, no? This seems like
>sensor failure, because I do not think cpu had 128 Celsius, without
>going through 100 Celsius, first.
>
>I had fan working at the time of shutdown, and machine was able to
>boot immediately afterwards. That means that 128 celsius was sensor
>error.

If it was near 128 C for some time, the plastic case the mainboard is 
housed in would have been extremely hot and one would have probably burned 
his fingers.


Jan Engelhardt
-- 
