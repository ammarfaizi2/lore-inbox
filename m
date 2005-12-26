Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVLZPQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVLZPQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 10:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVLZPQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 10:16:48 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:18353 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750812AbVLZPQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 10:16:48 -0500
Subject: Re: [PATCH] USB_BANDWIDTH documentation change
From: Lee Revell <rlrevell@joe-job.com>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0512261050100.4021@be1.lrz>
References: <Pine.LNX.4.58.0512261050100.4021@be1.lrz>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 10:06:23 -0500
Message-Id: <1135609583.8293.35.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-26 at 11:25 +0100, Bodo Eggert wrote:
> Document the current status of CONFIG_USB_BANDWITH implementation.

Since most systems use uhci-hcd and/or ehci-hcd maybe we should just
mark it BROKEN?  Or EXPERIMENTAL?

Lee

