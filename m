Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVCDPBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVCDPBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 10:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVCDPBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 10:01:37 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:34746 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262776AbVCDPAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 10:00:39 -0500
Subject: Re: [PATCH][MMC] Secure Digital (SD) support
From: Marcel Holtmann <marcel@holtmann.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
In-Reply-To: <422701A0.8030408@drzeus.cx>
References: <422701A0.8030408@drzeus.cx>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 16:00:32 +0100
Message-Id: <1109948432.8058.57.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

> Here are the patches for Secure Digital support that I've been sitting 
> on for a while. I tried to get some feedback on inclusion of this 
> previously but since I didn't get any I'll just submit the thing.
> It was originally diffed against 2.6.10 but it applies to 2.6.11 just 
> fine (only minor fuzz).

lately I got a request for the support of a Bluetooth SD card. These are
using SDIO and I think at the moment only memory cards are handled. Do
you have any plans for SDIO support?

Regards

Marcel


