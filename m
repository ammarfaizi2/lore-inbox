Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965381AbWAIAqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965381AbWAIAqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965380AbWAIAqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:46:36 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:61669 "EHLO
	linux") by vger.kernel.org with ESMTP id S965064AbWAIAqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:46:36 -0500
Message-Id: <20060108231235.153748000@linux>
Date: Mon, 09 Jan 2006 00:12:35 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] RTC subsystem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,

  updated version of my proposal for an RTC Subsystem. 

 I've fixed some locking issues, thanks to Dmitry Torokhov
 and added a driver for the Dallas/Maxim DS1672 Timekeeping
 chip.

 The subsystem should now be capable to handle all
 of the existing standalone drivers. 

 As usual, your feedback is highly appreciated.

--

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it
