Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWC3IpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWC3IpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWC3IpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:45:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:990 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751100AbWC3IpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:45:24 -0500
Date: Thu, 30 Mar 2006 10:45:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: meminfo: buffers vs cache
Message-ID: <Pine.LNX.4.61.0603301043490.20574@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


I am wondering what the difference between Buffers and Cached is. Does 
anyone know? (Link to FAQ?)

             total       used       free     shared    buffers     cached
Mem:       2075064    2012088      62976          0      96864    1401304
-/+ buffers/cache:     513920    1561144
Swap:        65952          8      65944

             total       used       free     shared    buffers     cached
Mem:        492280     486300       5980          0          4     460852
-/+ buffers/cache:      25444     466836
Swap:       514040          0     514040


Jan Engelhardt
-- 
