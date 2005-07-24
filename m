Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVGXPJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVGXPJi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 11:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVGXPJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 11:09:36 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:32960 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261330AbVGXPJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 11:09:35 -0400
Date: Sun, 24 Jul 2005 17:09:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RTC Timezone
Message-ID: <Pine.LNX.4.61.0507241707140.11580@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


My RTC clock is set to the local timezone. However, when I boot linux using 
the -b option, to stop by a shell before the bootscripts begin, the clock is 
exaclty two hours ahead.
Is the timezone stored in the RTC? If no, how can Linux know I am in UTC+0200?



Jan Engelhardt
-- 
