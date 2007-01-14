Return-Path: <linux-kernel-owner+w=401wt.eu-S1750896AbXANOTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXANOTR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 09:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbXANOTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 09:19:17 -0500
Received: from www.osadl.org ([213.239.205.134]:41136 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750896AbXANOTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 09:19:17 -0500
Subject: Re: [patch 2/3] Scheduled removal of SA_xxx interrupt flags fixups
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20070114124252.GA4809@elte.hu>
References: <20070114081905.135797900@inhelltoy.tec.linutronix.de>
	 <20070114081926.967534281@inhelltoy.tec.linutronix.de>
	 <20070114124252.GA4809@elte.hu>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 15:25:23 +0100
Message-Id: <1168784723.2941.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-14 at 13:42 +0100, Ingo Molnar wrote:
> i have tested your patch-queue ontop of rc4-mm1 (trivial reject fixups 
> are below), it builds and boots fine.
>
> Acked-by: Ingo Molnar <mingo@elte.hu>

You tested my yesterday queue against rc2-mm1. The patches in the mail
are against rc4-mm1 and contain the fix already.

	tglx


