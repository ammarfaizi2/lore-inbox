Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWBSXeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWBSXeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWBSXeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:34:44 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:2242 "EHLO
	linux") by vger.kernel.org with ESMTP id S932412AbWBSXeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:34:44 -0500
Message-Id: <20060219232211.368740000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 20 Feb 2006 00:22:11 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Cc: dtor_core@ameritech.net
Subject: [PATCH 00/11] RTC subsystem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello,

  this is me again with this shining new
 RTC subsystem :)

 quick changelog:

 - attribute groups
 - mutexes
 - fixed another bug in pcf8563 detection 

 Many thanks to all the people who contributed
 with comments both privately and on this ml.

--

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

--
