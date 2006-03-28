Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWC0XyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWC0XyU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWC0XyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:54:20 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:7597 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932103AbWC0XyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:54:19 -0500
Message-ID: <4428872E.3020308@wolfmountaingroup.com>
Date: Mon, 27 Mar 2006 17:45:34 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?RnJpZWRyaWNoIEfDtnBlbA==?= <shado23@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hda-intel woes
References: <20060327231049.GA30641@localhost.in.y0ur.4ss>
In-Reply-To: <20060327231049.GA30641@localhost.in.y0ur.4ss>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Visit www.redhat.com.

Purchase a support contract for customer service, fastest way to get help.

Jeff

Friedrich Göpel wrote:

>This same message was sent to the alsa mailinglist 3 weeks ago,
>but it still seems to be waiting on being moderated, so I'm resending
>this here.
>
>
>
>Hi,
>
>I tried installing linux on my sister's new acer extensa 6700 laptop.
>I tried Fedora FC4, FC5 test 3 and now Gentoo with various kernel and
>alsa versions (specifically 1.0.10 and 1.0.11-rc3 and whatever is in
>fedora before and after a full update).
>Also I set up a friends vaio laptop also with an intel hd audio chip,
>which is working peachy.
>I also tried model=basic/hp/fujitsu just in case.
>
>Just to preempt the question: I did unmute and raise the mixer levels.
>
>Anyways the damn thing is not to be convinced to produce a single
>sound.
>
>In light of this I suppose Acer did something nasty to that chip.
>
>I'm attatching here the relevant part of lspci -vv in hopes of somebody
>being either able to point out a fix or tell me if it's going to be
>supported sometime soon.
>
>I could pose as a genuea pig if neccessary.
>Also if there is any further information I should gather just tell me.
>
>Otherwise it's back to windows for my sister I guess.
>
>PS. I'm not subscribed to the list so please CC me.
>Thanks.
>
>00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
>        Subsystem: Acer Incorporated [ALI] Unknown device 008f
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Interrupt: pin A routed to IRQ 177
>        Region 0: Memory at d000c000 (64-bit, non-prefetchable) [size=16K]
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [70] Express Unknown type IRQ 0
>                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
>                Device: Latency L0s <64ns, L1 <1us
>                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
>                Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
>                Link: Latency L0s <64ns, L1 <1us
>                Link: ASPM Disabled CommClk- ExtSynch-
>                Link: Speed unknown, Width x0
>        Capabilities: [100] Virtual Channel
>        Capabilities: [130] Unknown (5)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

