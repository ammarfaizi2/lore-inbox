Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUC3LL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 06:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbUC3LLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 06:11:33 -0500
Received: from law10-f51.law10.hotmail.com ([64.4.15.51]:1549 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263603AbUC3LLU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 06:11:20 -0500
X-Originating-IP: [141.156.159.253]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: mgross@linux.co.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.4 - APIC Errors
Date: Tue, 30 Mar 2004 11:11:19 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F51AWiZAtGYkN0001a59c@hotmail.com>
X-OriginalArrivalTime: 30 Mar 2004 11:11:19.0351 (UTC) FILETIME=[BA12F470:01C41647]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The motherboard has more than adequate cooling and is not touched and in a 
proper cooled environment.

I do not recall seeing these in Kernel 2.6.3, although I am not 100% 
certain.

Seriously, what would cause such APIC errors?


>From: Mark Gross  <mgross@linux.co.intel.com>
>To: "Justin Piszcz" <jpiszcz@hotmail.com>
>Subject: Re: Linux Kernel 2.6.4 - APIC Errors
>Date: Mon, 29 Mar 2004 16:11:28 -0800
>
>On Monday 29 March 2004 10:16, Justin Piszcz wrote:
> > Does anyone know what would cause these APIC errors?
>
>Pepsi on your motherboard?
>
>--mgross
>
> >
> > # dmesg
> > APIC error on CPU0: 40(40)
> > APIC error on CPU0: 40(40)
> > APIC error on CPU0: 40(40)
> >
> > Linux l1 2.6.4 #1 Thu Mar 18 10:11:29 EST 2004 i686 unknown unknown
> > GNU/Linux
> > processor	: 0
> > vendor_id	: GenuineIntel
> > cpu family	: 15
> > model		: 2
> > model name	: Intel(R) Pentium(R) 4 CPU 2.53GHz
> > stepping	: 7
> > cpu MHz		: 2546.123
> > cache size	: 512 KB
> > fdiv_bug	: no
> > hlt_bug		: no
> > f00f_bug	: no
> > coma_bug	: no
> > fpu		: yes
> > fpu_exception	: yes
> > cpuid level	: 2
> > wp		: yes
> > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
>pat
> > pse36
> > clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> > bogomips	: 5029.88
> >
> > 00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 
>0655
> > 00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual
> > PCI-to-PCI
> > bridge (AGP)
> > 00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 
>0963
> > (rev
> > 04)
> > 00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
> > 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
> > 00:07.0 Unknown mass storage controller: Promise Technology, Inc. 20269
> > (rev 02)
> > 00:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
> > 07) 00:08.1 Input device controller: Creative Labs SB Live! MIDI/Game 
>Port
> > (rev 07)
> > 00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 
>03)
> > 00:0f.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702 
>Gigabit
> > Ethernet (rev 02)
> > 01:00.0 VGA compatible controller: nVidia Corporation NV28 [GeForce4 Ti
> > 4800 SE]
> > (rev a1)
> >
> > _________________________________________________________________
> > Free up your inbox with MSN Hotmail Extra Storage. Multiple plans
> > available.
> > 
>http://join.msn.com/?pgmarket=en-us&page=hotmail/es2&ST=1/go/onm00200362ave
> >/direct/01/
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
>in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>

_________________________________________________________________
MSN Toolbar provides one-click access to Hotmail from any Web page – FREE 
download! http://toolbar.msn.com/go/onm00200413ave/direct/01/

