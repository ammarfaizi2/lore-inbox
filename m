Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUJTQEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUJTQEy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUJTQDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:03:47 -0400
Received: from zone3.gcu-squad.org ([217.19.50.74]:19465 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S268501AbUJTQCR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:02:17 -0400
Date: Wed, 20 Oct 2004 17:57:41 +0200 (CEST)
To: greg@kroah.com
Subject: Re: [BK PATCH] I2C update for 2.6.9
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <dLpBLFBx.1098287861.7976600.khali@gcu.info>
In-Reply-To: <20041020001603.GA11393@kroah.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

>Here are some i2c driver fixes and updates for 2.6.9.  There is a new
>chip and a new bus driver, as well as a bunch of minor fixes.  The
>majority of these patches have been in the past few -mm releases.

It looks like only three of these patches actually hit the lm_sensors
mailing-list, and I don't see any (not even this annoucement) on the
LKML. Could it be that your patch generator went bad somehow?

Thanks,
Jean
