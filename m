Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271026AbTHQU6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271037AbTHQU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:58:23 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:33387 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271026AbTHQU6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:58:21 -0400
Message-ID: <3F3F7C5E.2070607@myrealbox.com>
Date: Sun, 17 Aug 2003 06:00:14 -0700
From: walt <wa1ter@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; NetBSD i386; en-US; rv:1.4) Gecko/20030723
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Dreker <patrick@dreker.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: nforce2 lockups
References: <fa.ih2vscq.35m1rs@ifi.uio.no> <fa.gbe06ic.1ki851c@ifi.uio.no>
In-Reply-To: <fa.gbe06ic.1ki851c@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Dreker wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Am Sunday 17 August 2003 21:27 schrieb Jussi Laako <jussi.laako@pp.inet.fi> 
> zum Thema Re: nforce2 lockups:
> 
>>On Fri, 2003-08-15 at 19:38, Alistair J Strachan wrote:
>>
>>>>NFORCE2: chipset revision 162
>>>
>>>I use APIC and ACPI on my EPoX 8RDA+, and I've never had any IO problems.
>>>So it seems unlikely that it is tied to a chipset revision.
>>
>>I have ASUS A7N8X Deluxe mobo with nForce2 rev 162 without any problems
>>(if not counting unability to enabe SiI SATA DMA mode with attached
>>Seagate Barracuda drive).
> 
> 
> I have the exact same Board (except I'm not using SATA), and it's a nightmare. 
> Best uptime so far: a little more than 16 hours. Usually it locks up a lot 
> earlier. When I do network transfers I can cause it to lock within a few 
> minutes. Under "the other OS" it runs without any problems.

A friend had lots of problems with his NForce2 mobo until he ran memtest86
and found that the memory was flaky.  His machine has been running linux
very well since he replaced the memory.  (Heh, two days ago  ;-)

I wonder if the NForce2 is a bit fussier about the quality of the memory
than other chipsets.

