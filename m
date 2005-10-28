Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbVJ1HEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbVJ1HEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVJ1HEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:04:42 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:45956 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965135AbVJ1HEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:04:41 -0400
Date: Fri, 28 Oct 2005 09:04:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: QoS in menuconfig screwed up
Message-ID: <Pine.LNX.4.61.0510280902470.6910@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


When CONFIG_NET_CLS is enabled, then "Firewall based classifier", "U32 
classifier" and some more appear under the "Network options" menu rather 
than "QoS and/or fair queueing" menu.
This bug is in the recently released 2.6.14. (And earlier).


Jan Engelhardt
-- 
