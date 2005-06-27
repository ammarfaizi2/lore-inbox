Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVF0Nbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVF0Nbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVF0NbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:31:11 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:23269 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262073AbVF0MQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:48 -0400
Message-Id: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:00 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 00/51] DVB update
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

nothing spectacular this time, mostly bugfixes, cleanups and support for new
card variants, plus the new Pluto2 driver. We also drop the skystar2 driver
which has been obsoleted by the flexcop-pci driver.
The patches apply fine against linux-2.6.12-git8 and linux-2.6.12-mm2.

Thanks,
Johannes

