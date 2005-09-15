Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbVIOU7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbVIOU7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbVIOU7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:59:12 -0400
Received: from [85.8.12.41] ([85.8.12.41]:37250 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1161022AbVIOU7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:59:10 -0400
Message-ID: <4329E09B.9020807@drzeus.cx>
Date: Thu, 15 Sep 2005 22:59:07 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Netdev List <netdev@vger.kernel.org>,
       ipw2100-admin@linux.intel.com, jt@hpl.hp.com
Subject: ipw2200 using old wireless extensions
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the inclusion of the ipw2200 driver and the update of the wireless
extensions I get my dmesg flooded with these:

eth0 (WE) : Driver using old /proc/net/wireless support, please fix driver !

Somebody please make the hurting go away :)

Rgds
Pierre
