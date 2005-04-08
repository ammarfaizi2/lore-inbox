Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVDHQ0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVDHQ0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 12:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVDHQ0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 12:26:42 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:58322 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262868AbVDHQ03 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 12:26:29 -0400
Date: Fri, 8 Apr 2005 18:21:41 +0200 (CEST)
To: ladis@linux-mips.org
Subject: Re: [PATCH] ds1337 4/4
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <AKwWUAUT.1112977301.6626650.khali@localhost>
In-Reply-To: <20050408123545.GA4961@orphique>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>,
       "James Chapman" <jchapman@katalix.com>, "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ladislav,

> (...) (And in ideal world
> firmware (such as U-Boot, RedBoot, etc.) should set this register).

Thanks for pointing the obvious out to me. You convinced me, this simply
doesn't belong to the kernel. So your patch is not needed.

I would still welcome a patch documenting the fact that the DS1339 is
compatible with the DS1337 and is supported by the ds1337 driver.

Thanks,
--
Jean Delvare
