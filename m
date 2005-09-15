Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVIOH7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVIOH7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVIOH7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:59:09 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:18108 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750843AbVIOH7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:59:06 -0400
Subject: Re: [patch 00/28] RFC/RFT: Input - sysfs integration
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20050915070131.813650000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 09:59:07 +0200
Message-Id: <1126771147.28510.16.camel@station6.example.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> The following set of patches deals with converting input subsystem
> to the driver model and intergrate it with sysfs. This allows us
> to remove custom-made input hotplug handler and finally have an
> option of netlink-only hotplug notifier.

do you have a GIT tree with all that changes that I can simply pull in
for testing?

Regards

Marcel


