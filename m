Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUC3V5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbUC3V5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:57:23 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:59628 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261419AbUC3V5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:57:16 -0500
Message-ID: <4069ED67.5050302@blueyonder.co.uk>
Date: Tue, 30 Mar 2004 22:57:59 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm1
References: <4069DC40.3070703@blueyonder.co.uk> <1080681249.3547.51.camel@watt.suse.com>
In-Reply-To: <1080681249.3547.51.camel@watt.suse.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Mar 2004 21:57:15.0842 (UTC) FILETIME=[F6BE2A20:01C416A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Tue, 2004-03-30 at 15:44, Sid Boyce wrote:
>  
>
>>It builds fine on x86_64 but locks up solid at ----
>>found reiserfs format "3.6" with standard journal
>>Hard disk light permanently on - 2.6.5-rc2 vanilla is the last one to 
>>boot fully, haven't tried 2.6.5-rc3 vanilla yet.
>>    
>>
>
>Have you tried booting with acpi=off?
>
>-chris
>
>
>
>  
>
With acpi=off, I get a string of messages
atkbd.c: Unknown key released (translated to set 0, code 0x41 on 
isa0060/serio0)
atkbd.c: Use 'setkeycodes 41 <keycode>' to make it known
Then it freezes with HD light solid on.
Before the messages above ---
********* Please consider a BIOS update.
********* Disabling USB legacy in the BIOS may also help.
Disabled USB legacy in the BIOS, with acpi=off it's back to the original 
freeze after the found reiserfs message.

I shall check to see if there is a later BIOS available.
Acer 1501LCe laptop, Athlon64 3000+, CD-RW/DVD, fireiwre port,  no 
floppy, no serial ports.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

