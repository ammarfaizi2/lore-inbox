Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275140AbRJLJqv>; Fri, 12 Oct 2001 05:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRJLJql>; Fri, 12 Oct 2001 05:46:41 -0400
Received: from oe34.law9.hotmail.com ([64.4.8.91]:20231 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S275140AbRJLJqc>;
	Fri, 12 Oct 2001 05:46:32 -0400
X-Originating-IP: [66.108.21.174]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Question on moving a firewall from 2.2.x to 2.4.x
Date: Fri, 12 Oct 2001 05:45:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE34QrttDRdNOUivlQo0000e388@hotmail.com>
X-OriginalArrivalTime: 12 Oct 2001 09:46:59.0390 (UTC) FILETIME=[D6532DE0:01C15302]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

    I've started migrating my new firewlls over to the 2.4.x kernels.

    In 2.2.x my general firewalling scripts had the following line:

echo 1 > /proc/sys/net/ipv4/ip_always_defrag

    This proc option appears to be missing in 2.4.x.  Had it been replaced
by something else or is it not needed anymore?
