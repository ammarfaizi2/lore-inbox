Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbTKJRrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 12:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTKJRrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 12:47:18 -0500
Received: from smtp4.cern.ch ([137.138.131.165]:11489 "EHLO smtp4.cern.ch")
	by vger.kernel.org with ESMTP id S264028AbTKJRrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 12:47:09 -0500
Keywords: CERN SpamKiller Note: -52
From: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: PCI with SiS: Cannot allocate resource.
Date: Mon, 10 Nov 2003 18:47:07 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311090742240.12198-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0311090742240.12198-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_b88r/v4WxJ8EToU"
Message-Id: <200311101847.07792.Alexander.Zviagine@cern.ch>
X-OriginalArrivalTime: 10 Nov 2003 17:47:06.0684 (UTC) FILETIME=[A857A7C0:01C3A7B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_b88r/v4WxJ8EToU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Davide,

On Sunday 09 November 2003 16:45, Davide Libenzi wrote:
> On Sun, 9 Nov 2003, Alexander ZVYAGIN wrote:
> > > Can you try to apply this over test9:
> > >
> > > http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.0-test9
> > >-bk1 3.bz2
> >
> > I see the same messages...
>
> $ cat /proc/interrupts
>
> Also you can try to disable:
>
> CONFIG_X86_UP_APIC
> CONFIG_X86_UP_IOAPIC
> CONFIG_X86_LOCAL_APIC
> CONFIG_X86_IO_APIC

Still the same.... See the attachments.

Thanks,
Alexander.

--Boundary-00=_b88r/v4WxJ8EToU
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
fthKAAA=

--Boundary-00=_b88r/v4WxJ8EToU
Content-Type: application/x-gzip;
  name="dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg.gz"

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
5t0YAAA=

--Boundary-00=_b88r/v4WxJ8EToU
Content-Type: text/plain;
  charset="iso-8859-1";
  name="interrupts"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="interrupts"

           CPU0       
  0:     182523          XT-PIC  timer
  1:          8          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
 11:        555          XT-PIC  ohci1394, eth0
 12:         54          XT-PIC  i8042
 14:       1370          XT-PIC  ide0
 15:          9          XT-PIC  ide1
NMI:          0 
ERR:          0

--Boundary-00=_b88r/v4WxJ8EToU
Content-Type: text/plain;
  charset="iso-8859-1";
  name="iomem"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="iomem"

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cc000-000ccfff : Extension ROM
000cd000-000cdfff : Extension ROM
000f0000-000fffff : System ROM
00100000-0dfeffff : System RAM
  00100000-0032fbf0 : Kernel code
  0032fbf1-003dceff : Kernel data
0dff0000-0dffffbf : ACPI Tables
0dffffc0-0dffffff : ACPI Non-volatile Storage
10000000-10000fff : 0000:00:0c.0
10001000-10001fff : 0000:00:0c.1
30000000-37ffffff : 0000:00:00.0
38000000-38000fff : 0000:00:01.1
  38000000-38000fff : sis900
38001000-38001fff : 0000:00:01.2
38002000-38002fff : 0000:00:01.3
38003000-38003fff : 0000:00:01.4
40000000-4f0fffff : PCI Bus #01
  40000000-47ffffff : 0000:01:00.0
    40000000-41ffffff : sisfb FB
50000000-560fffff : PCI Bus #01
  50000000-5001ffff : 0000:01:00.0
    50000000-5001ffff : sisfb MMIO
e9100000-e9103fff : 0000:00:0d.0
e910f000-e910f7ff : 0000:00:0d.0
  e910f000-e910f7ff : ohci1394
fffc0000-ffffffff : reserved

--Boundary-00=_b88r/v4WxJ8EToU--

