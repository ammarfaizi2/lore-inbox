Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUCNVBO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 16:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUCNVBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 16:01:14 -0500
Received: from bender.bawue.de ([193.7.176.20]:52925 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261604AbUCNVBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 16:01:13 -0500
Date: Sun, 14 Mar 2004 22:01:07 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: linux-kernel@vger.kernel.org
Subject: Re: NMI watchdog in 2.6.3-mm4/2.6.4-mm1
Message-ID: <20040314210107.GA4492@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	linux-kernel@vger.kernel.org
References: <200403141212.i2ECC5vo008463@harpo.it.uu.se> <20040314161233.GA2955@sommrey.de> <Pine.LNX.4.58.0403141545330.28447@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403141545330.28447@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 03:52:09PM -0500, Zwane Mwaikambo wrote:

> 
> I think the pending problem then is nmi_watchdog=1 working erratically.
> Does 2.6.3 work for you?

Plain 2.6.3 with nmi_watchdog=1 does not work, 2.6.3-mm1 is the only
working kernel I have seen.

-jo

-- 
-rw-r--r--    1 jo       users          80 2004-03-14 21:18 /home/jo/.signature
