Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131346AbRCHMLm>; Thu, 8 Mar 2001 07:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131347AbRCHMLc>; Thu, 8 Mar 2001 07:11:32 -0500
Received: from [193.120.151.1] ([193.120.151.1]:37371 "EHLO mail.asitatech.com")
	by vger.kernel.org with ESMTP id <S131346AbRCHMLQ>;
	Thu, 8 Mar 2001 07:11:16 -0500
From: "John Brosnan" <jbrosnan@asitatech.ie>
To: <linux-kernel@vger.kernel.org>
Subject: v0.92,Tulip, carrier errors
Date: Thu, 8 Mar 2001 12:31:16 -0000
Message-ID: <00c201c0a7cb$ab70a5e0$8d7fa8c0@NTWIGGY.asitatech.ie>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

using Donald Becker's tulip.c:v0.92 on Linux 2.2.16, 
if I bring down an interface using ifconfig and
bring it back up again, when I transmit data on the 
interface I see lots of carrier errors and very bad 
performance.  Is this a known problem ? 
Any workarounds/fixes ?

thanks, 

John


