Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVIOHzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVIOHzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVIOHzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:55:18 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:15804 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750708AbVIOHzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:55:17 -0400
Subject: Re: [patch 09/28] Input: convert net/bluetooth to dynamic
	input_dev allocation
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20050915070302.931769000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
	 <20050915070302.931769000.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 09:54:54 +0200
Message-Id: <1126770894.28510.10.camel@station6.example.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> Input: convert net/bluetooth to dynamic input_dev allocation
> 
> This is required for input_dev sysfs integration
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

on the condition your stuff got merged, then this patch is ok with me.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


