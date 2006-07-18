Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWGRPwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWGRPwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWGRPwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:52:33 -0400
Received: from mga03.intel.com ([143.182.124.21]:3462 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750829AbWGRPwc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:52:32 -0400
X-IronPort-AV: i="4.06,255,1149490800"; 
   d="scan'208"; a="67662716:sNHT8193991190"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: ACPI on ASUS A7S333 - Kernel 2.6.13 and higher
Date: Tue, 18 Jul 2006 23:51:41 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1120713@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI on ASUS A7S333 - Kernel 2.6.13 and higher
thread-index: AcaqfsP8av+p/itqQAinjhkxD388hgAAx+HA
From: "Yu, Luming" <luming.yu@intel.com>
To: "icoslau" <icoslau@uol.com.br>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Jul 2006 15:51:45.0129 (UTC) FILETIME=[1202ED90:01C6AA82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please file bug on bugzilla.kernel.org in acpi category with all required information:
dmesg, acpidump output, lspci -vvx, /proc/interrupts,...

Thanks
Luming 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org 
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of icoslau
Sent: 2006Äê7ÔÂ18ÈÕ 23:24
To: linux-kernel
Subject: ACPI on ASUS A7S333 - Kernel 2.6.13 and higher

Hello, my name is Adalberto and i live in Brazil.

I have a problem which must be simpler so that yours they can help me.

Until version 2.6.12 of kernel, in any distribution my MOBO 
ASUS A7S333 works very well, mainly for the fact to use ACPI 
and disconnect total (power off) when commanded.    

However of version 2.6.13 in ahead I do not obtain the same result.

Already I tried to modify DSDT, to qualify and to incapacitate 
ACPI or APM in kernel, to pass options to boot as pci=noacpi 
amongst as much others, but in these finish versions of kernel, 
the APM only obtains disconnect (power off) schemes it.
The problem is that with qualified APM this schemes tends to 
stop in all the times in others words, the system hangs.

My question, if somebody will be able to help me, is if it is 
possible, already I tried but without success, to place in 
kernel 2.6.13 or higher the instructions of ACPI of kernel 
2.6.12. I try copy the acpi from source of 2.6.12 and paste in 
2.6.13 but in kernel compilation are many errors in .c files of acpi.

I thank any very I assist that they will be able to give to me 
in this direction. 

Sorry for my english, its not good.

-
To unsubscribe from this list: send the line "unsubscribe 
linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
