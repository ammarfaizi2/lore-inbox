Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbTDJKrJ (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 06:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbTDJKrJ (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 06:47:09 -0400
Received: from [203.124.139.208] ([203.124.139.208]:22503 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id S264022AbTDJKrI (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 06:47:08 -0400
Reply-To: <chandrasekhar.nagaraj@patni.com>
From: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Unresolved symbol prefetch on RH AS2.1
Date: Thu, 10 Apr 2003 16:35:50 +0530
Message-ID: <000301c2ff51$263d2350$e9bba5cc@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a custom driver which works on Red Hat 7.2.
The same driver when compiled and inserted on Red Hat Advanced Server
(kernel 2.4.9 e-3) gives me the following unresolved symbol error

insmod sddlmadrv.o (This is the custom driver which works on 7.2)
sddlmadrv.o: unresolved symbol prefetch

Can anybody tell me what changes need to be done  so that the driver could
be inserted.

Thanks and Regards
Chandrasekhar



