Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbSL1VCO>; Sat, 28 Dec 2002 16:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSL1VCO>; Sat, 28 Dec 2002 16:02:14 -0500
Received: from f158.law7.hotmail.com ([216.33.237.158]:13330 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265895AbSL1VCN>;
	Sat, 28 Dec 2002 16:02:13 -0500
X-Originating-IP: [198.70.228.18]
From: "Randy S." <hey_randy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: agpgart and nforce2 -- I need your help!
Date: Sat, 28 Dec 2002 16:10:28 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F158LsxpTljBOh8s4KW00000063@hotmail.com>
X-OriginalArrivalTime: 28 Dec 2002 21:10:28.0776 (UTC) FILETIME=[8C686280:01C2AEB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

   I'm currently developing nForce2 support for agpgart and I'm looking for 
someone who can help me...

   Is anybody out there running nvagp with nforce2 chipset and an nvidia 
video card?

   If so, I'd really appreciate it if someone could volunteer to run a 
couple simple tests for me. I need a couple PCI register dumps for the 
bridge.

Please CC me in any replies, as I don't currently subscribe (but I do check 
the archives regularly).

   For those who are interested, I have a patch to agpgart that does detect 
nforce2 chipset and reads the aperture base/size registers correctly -- I'm 
now working on the memory mask, control register, and error status 
registers.  What I have thus far allows me to run a 3rd party video driver 
(fglrx in my case) with nforce 2. It just doesn't have 3d acceleration yet.

Thanks!
   Randy Sharo
   hey_randy@hotmail.com


_________________________________________________________________
MSN 8 limited-time offer: Join now and get 3 months FREE*. 
http://join.msn.com/?page=dept/dialup&xAPID=42&PS=47575&PI=7324&DI=7474&SU= 
http://www.hotmail.msn.com/cgi-bin/getmsg&HL=1216hotmailtaglines_newmsn8ishere_3mf

