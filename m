Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWCRRVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWCRRVR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 12:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWCRRVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 12:21:16 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:16373 "EHLO
	linux") by vger.kernel.org with ESMTP id S1750721AbWCRRVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 12:21:16 -0500
Message-Id: <20060318171946.821316000@towertech.it>
User-Agent: quilt/0.43-1
Date: Sat, 18 Mar 2006 18:19:46 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: [PATCH 00/18] RTC subsystem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 RTC subsystem. 

 Original RFC available at http://lkml.org/lkml/2005/12/20/220

 Changelog. Between parentheses is the name
 of the person that suggested the change.

 - license and tristate for rtc-lib.c (Andrian Bunk)
 - added driver for ST M48T86

 The following patches have been incorporated:

  none

 The following items are in the TODO:

 - Documentation of exported functions
 - Handling of max_user_freq
 - 11 min ntp update mode

--

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

--
