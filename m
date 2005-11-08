Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVKHR5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVKHR5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVKHR5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:57:18 -0500
Received: from netzweb.gamper-media.ch ([157.161.128.137]:52488 "EHLO
	ns1.netzweb.ch") by vger.kernel.org with ESMTP id S964923AbVKHR5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:57:18 -0500
From: "Miro Dietiker, MD Systems" <info@md-systems.ch>
To: <linux-kernel@vger.kernel.org>
Cc: "'Denis Vlasenko'" <vda@ilport.com.ua>
Subject: AW: Compiling kernel for amd 8131 chipset
Date: Tue, 8 Nov 2005 18:56:53 +0100
Organization: MD Systems
Message-ID: <02a601c5e48d$d02d0460$4001a8c0@MDSYSPORT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <200511081804.10761.vda@ilport.com.ua>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I couldn't find any thread about this topic.
>> Surprisingly if I start "knoppix 3.91 with 2.8.11" the chipset is
being
>> detected (lspci)

><joke>
>Apparently support for the 8131 was added sometime before 2.8.11 kernel
>release.
></joke>

*rofl* sure 2.6.11 @ knoppix's ;)

>> Do you have any idea for doing that?

>Take knoppix's .config and compile latest 2.6 using it (with "make
>oldconfig" step as usual).

So i did, using the same kernel 2.6.11 as knoppix 3.91
this time without applying the patch from amd for 8131 and also without
the patch of bc5704

Wow! System works! *excited*

Now I'm trying to compile 2.6.14 and enjoy my brand net servers :-)

Thanx! - Miro

