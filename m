Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVCVMUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVCVMUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVCVMUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:20:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59067 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261154AbVCVMUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:20:13 -0500
Date: Tue, 22 Mar 2005 13:20:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sean Russell <ser@ser1.net>
cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1[01] freeze on x86_64
In-Reply-To: <423FC2ED.1090704@ser1.net>
Message-ID: <Pine.LNX.4.61.0503221317220.10134@yvahk01.tjqt.qr>
References: <423F5152.2010303@ser1.net> <m13buo3vew.fsf@muc.de>
 <423FC2ED.1090704@ser1.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >    acpi_thermal-0400 [23] acpi_thermal_get_trip_: Invalid active
>> > threshold [0]
>> 
>> You mean you got this in /var/log/messages?
>
> Yes, in /var/log/messages.  The lock up occurs without warning, so the only
> opportunity I have to look for error messages is in the syslogs.
>
>> Can you connect a serial console or netconsole and see if that 
>> 
> Er... by serial console, I assume you mean via a serial cable and some other
> device.  If so, then no, I don't have that capability.  I didn't know about
> netconsole before you mentioned it; I'll do some research and set it up.  I do
> have a second computer (well, my wife's laptop is also running Linux) that I
> could use to monitor UDP traffic, if I can figure out what to use as a client
> to capture the messages.  This may take me a couple of days.

Serial console -- only requires a serial cable, available in the next computer 
store -- also works with non-Linux, non-x86 and (mostly) systems-w/o-compiler.


Jan Engelhardt
-- 
