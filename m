Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVAXD2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVAXD2d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 22:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVAXD2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 22:28:33 -0500
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:38365 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S261430AbVAXD22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 22:28:28 -0500
From: "Atul Bhouraskar" <atul.bhouraskar@acoustic-technologies.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: irq 3: nobody cared! with Intel 31244 SATA.... Advice??
Date: Mon, 24 Jan 2005 14:28:34 +1100
Message-ID: <007301c501c4$c8ae2180$0d65a8c0@SHARK>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <Pine.LNX.4.21.0501232056510.26468-100000@ernie.virtualdave.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel- 
> owner@vger.kernel.org] On Behalf Of David Sims
> Sent: Monday, 24 January 2005 13:57
> 
> I then downloaded and built kernel 2.6.10 which boots up fine without 
> the sata_vsc module.... If you then load the sata_vsc module manually 
> using "modprobe sata_vsc" it will cause the following error once for 
> each attached disk drive:
> 
> Jan 23 09:08:21 linux kernel: Disabling IRQ #3
> Jan 23 09:08:23 linux kernel: irq 3: nobody cared!

I once had the same problem; I think enabling APIC solved it....

Atul

