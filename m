Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSH3XT1>; Fri, 30 Aug 2002 19:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSH3XT0>; Fri, 30 Aug 2002 19:19:26 -0400
Received: from [64.246.18.23] ([64.246.18.23]:1677 "EHLO ensim.2hosting.net")
	by vger.kernel.org with ESMTP id <S314138AbSH3XTY>;
	Fri, 30 Aug 2002 19:19:24 -0400
Reply-To: <steve@tuxsoft.com>
From: "Stephen Lee" <steve@tuxsoft.com>
To: "'Christopher Keller'" <cnkeller@interclypse.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.18: APM & ASUS A7M266-D
Date: Fri, 30 Aug 2002 18:27:42 -0500
Message-ID: <003101c2507c$d9e70d00$1401a8c0@saturn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <1030744641.2588.64.camel@c_keller.beamreachnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same board and CPU's.  Mine is configured for ACPI with Bus
Manager and System compiled as modules.  Works great.

Steve


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Christopher
Keller
Sent: Friday, August 30, 2002 4:57 PM
To: linux-kernel@vger.kernel.org
Subject: 2.4.18: APM & ASUS A7M266-D

Kernel 2.4.18-X (RedHat version)
AMD MP 1900 CPU's

APM is enabled in the BIOS, yet the kernel presumably disables it with a
message along the lines of unsafe for dual CPU's (apologies, don't have
the box in front of me).

The result, as far as I can tell, is that the machine doesn't power off
when executing a shutdown/init 0. It simply displays the "Power Down"
message and sits there. 

Booting with the "apm=power-off" flag doesn't seem to have any effect. 

Could someone enlighten me as to what's up?

-- 
Homepage: http://interclypse.net
Registered Linux user #215241 (http://counter.li.org/)


