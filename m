Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270672AbTHLTT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 15:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbTHLTT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 15:19:56 -0400
Received: from smtp2.libero.it ([193.70.192.52]:54264 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S270672AbTHLTTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 15:19:55 -0400
Message-ID: <000c01c36106$59dab7b0$0100a8c0@spl33n>
From: "Ale" <donkyshot@ngi.it>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: input devices
Date: Tue, 12 Aug 2003 21:17:19 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: when compiling it stops with a vmlinuz
error message.
[2.] Full description of the problem/report: I did my make menuconfig and
I've checked all input core support with "M" (module). When I did make
bzImage it stops with a vmlinux error message due to some input core support
error.So I had to check with "*" all the options. without * bzImage doesn't
work.
[3.] Keywords (i.e., modules, networking, kernel): kernel, vmlinuz, input
core support
[4.] Kernel version (from /proc/version): 2.4.21
[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment Acer Travelmate 230xv
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):Intel Celeron 1.7
[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds: MUST check with "*" all the
options

sorry for my disgusting english :P

Alessio Castello (.it)

