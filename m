Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTEIDaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 23:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbTEIDaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 23:30:25 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:3456 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S262282AbTEIDaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 23:30:24 -0400
Date: Thu, 8 May 2003 23:43:02 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Driver ordering from boot: or lilo.conf 
In-Reply-To: <Pine.LNX.4.55L.0305082213420.9139@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.55.0305082336120.306@filesrv1.baby-dragons.com>
References: <Pine.LNX.4.55L.0305082213420.9139@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello All ,  I am having a difficulty with the dpt_120 driver &
	the sym2-53c8xx driver .  I have just placed a Adaptec 2010s raid
	controller in my system & it now wants to take device 0800 away
	from the sym2 driver at boot time .  ALL drivers are statically
	built into the kernel .  Is there a way at either of the methods
	stated in the subjec to get the order back so that I have my real
	root file system back on 0800 ?  Tia ,  JimL
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
