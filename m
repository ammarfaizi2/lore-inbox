Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWBMWzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWBMWzX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWBMWzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:55:22 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:45153 "EHLO
	linux") by vger.kernel.org with ESMTP id S1030229AbWBMWzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:55:21 -0500
Message-Id: <20060213225416.865078000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 13 Feb 2006 23:54:16 +0100
From: Alessandro Zummo <azummo-vger@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] RTC subsystem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello,

  this release of the new RTC subsystem has got
 a few locking issues fixed as well as new
 drivers for the Ricoh RS5C372A/B and
 Philips PCF8563/Epson RTC8564.

  Detection routines have been improved
 in some drivers, while some others now require
 a specific probe parameter in order to
 avoid spurious writes on I2C eeprom chips.

 As usual, your feedback is highly appreciated.

--

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

--
