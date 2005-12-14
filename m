Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVLNGur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVLNGur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 01:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVLNGur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 01:50:47 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23458
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751196AbVLNGuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 01:50:46 -0500
Date: Tue, 13 Dec 2005 22:50:23 -0800 (PST)
Message-Id: <20051213.225023.74302540.davem@davemloft.net>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFT/RFC] sparcspkr: register with driver core as a platfrom
 device
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200512140105.46090.dtor_core@ameritech.net>
References: <200512140105.46090.dtor_core@ameritech.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: Wed, 14 Dec 2005 01:05:45 -0500

> The following patch converts sparcspkr into a platform device,
> putting it into sysfs hierarchy, providing parent device for input
> device and allowing using "bind" and "unbind" driver attributes to
> acquire and release device.

Looks fine to me.
