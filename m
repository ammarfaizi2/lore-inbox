Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUDTMmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUDTMmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 08:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbUDTMmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 08:42:44 -0400
Received: from gprs214-3.eurotel.cz ([160.218.214.3]:33409 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262750AbUDTMl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 08:41:29 -0400
Date: Tue, 20 Apr 2004 14:41:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dark <dark@chello.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suspend to ram
Message-ID: <20040420124119.GA22052@elf.ucw.cz>
References: <20040408123234.GA1922@gep.morknat.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040408123234.GA1922@gep.morknat.no-ip.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm trying to make ACPI suspend to ram work on my computer with kernel- 
> 2.6.5. Saying echo -n "mem" >/sys/power/state seems to work fine and it  
> suspends the machine, but it fails to resume - it halts with blank  
> screen.
> The kernel version is 2.6.5, with the bootsplash patch, and the machine  
> is: Asus A7V8X-X motherboard (with the latest bios), integrated via8235  
> sound, and integrated via-rhine eth and Geforce2 video (with the binary  
> driver from Nvidia).

Read Documentation/power/video.txt.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
