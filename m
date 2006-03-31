Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWCaKEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWCaKEo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWCaKEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:04:44 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:12845 "EHLO
	linux") by vger.kernel.org with ESMTP id S932071AbWCaKEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:04:44 -0500
Message-Id: <20060331100423.175139000@towertech.it>
User-Agent: quilt/0.43-1
Date: Fri, 31 Mar 2006 12:04:23 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@osdl.org
Subject: [PATCH 00/10] RTC subsystem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 RTC subsystem. 

 - general cleanup of white spaces and error messages
 - new NEC VR41XX driver
 - fixed some sysfs error codes
 - oscillator handling in ds1672
--

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

--
