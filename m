Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUCKUer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUCKUbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:31:21 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:517 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261718AbUCKUaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:30:24 -0500
Subject: Re: 2.6.4-mm1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Redeeman <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1079024816.5325.2.camel@redeeman.linux.dk>
References: <20040310233140.3ce99610.akpm@osdl.org>
	 <1079024816.5325.2.camel@redeeman.linux.dk>
Content-Type: text/plain
Message-Id: <1079036974.856.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 11 Mar 2004 21:29:34 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-11 at 18:06, Redeeman wrote:
> hey andrew, i have a problem with this kernel, when it boots, it lists
> vp_ide and stuff, and then suddenly after that my screen gets flodded
> with sys traces and stuff, i cant even read it, so fast they come, and
> the syste doesnet go further, i havent tried 2.6.4 vanilla yet, but i
> will now.

I'm having similar problems, with the kernel crashing with not syncing
in interrupt error after a lot of oopses and BUGs. I'm trying to find
which patch is causing this, since 2.6.4-rc2-mm1 and 2.6.4 work fine.

I'll post my findings, when they are ready.

