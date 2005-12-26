Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVLZVsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVLZVsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 16:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVLZVsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 16:48:18 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:49281 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750833AbVLZVsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 16:48:17 -0500
Date: Mon, 26 Dec 2005 22:49:25 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Bodo Eggert <7eggert@gmx.de>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] USB_BANDWIDTH documentation change
In-Reply-To: <1135609583.8293.35.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0512262244480.22764@be1.lrz>
References: <Pine.LNX.4.58.0512261050100.4021@be1.lrz> <1135609583.8293.35.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005, Lee Revell wrote:
> On Mon, 2005-12-26 at 11:25 +0100, Bodo Eggert wrote:

> > Document the current status of CONFIG_USB_BANDWITH implementation.
> 
> Since most systems use uhci-hcd and/or ehci-hcd maybe we should just
> mark it BROKEN?  Or EXPERIMENTAL?

It is EXPERIMENTAL, but the current documentation sounds like "YOU REALLY
WANT THIS !!!1", and I /guess/ that would be true for ohci-hcd users.

-- 
The complexity of a weapon is inversely proportional to the IQ of the
weapon's operator.
