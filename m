Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTDPOrY (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTDPOrY 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:47:24 -0400
Received: from h000.c000.snv.cp.net ([209.228.32.64]:55806 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S264415AbTDPOrW 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:47:22 -0400
X-Sent: 16 Apr 2003 14:59:14 GMT
Message-ID: <003e01c30428$bb6de410$6901a8c0@athialsinp4oc1>
From: "Brien" <admin@brien.com>
To: <linux-kernel@vger.kernel.org>
Subject: my dual channel DDR 400 RAM won't work on any linux distro
Date: Wed, 16 Apr 2003 10:59:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I posted this on some forums and they recommended that I try here)

Hi,

I have a Gigabyte SINXP1394 motherboard, and 2 Kingston 512 MB DDR 400 (CL
2.5) RAM modules installed. Whenever I try to install any Linux
distribution, I always get a black screen after the kernel loads, when I
have dual channel enabled; If I take out 1 of the RAM modules (either one),
everything works as it should -- it's not a bad module (works perfectly
under Windows by the way). I can't disable dual channel without taking out
half of my RAM, and I really do not want to run with only half of it. Does
anyone have any idea how I can fix this problem, or is it something that
needs to be updated in the kernel?

Thanks for any info.


