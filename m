Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275739AbRJYRDo>; Thu, 25 Oct 2001 13:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275734AbRJYRDf>; Thu, 25 Oct 2001 13:03:35 -0400
Received: from ns1.jasper.com ([64.19.21.34]:56458 "EHLO ersfirep1")
	by vger.kernel.org with ESMTP id <S275680AbRJYRDX>;
	Thu, 25 Oct 2001 13:03:23 -0400
From: "Radivoje Todorovic" <radivojet@jaspur.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: [NETWORK MODULE PERFORMANCE]: How to measure it?
Date: Thu, 25 Oct 2001 12:02:07 -0500
Message-ID: <BOEOJGNGENIJJMAOLHHCEEIKCEAA.radivojet@jaspur.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am confronted with somewhat hard problem. Say one develops Network Module
X, i.e. using Netfilter hooks. X will (simply) mangle the packets and then
forward them or do whatever. How can I measure the performance of X module?
I am not sure exactly what I am asking but say, I have a Linux router with X
module running and I need to get information what is the CPU usage under
heavy traffic with, and without X module. Actually it would be nice to see
the latency per-packet that X introduces and how it changes if the volume of
traffic increases.

Any hint would be highly appreciated.

Rade

