Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWFSMa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWFSMa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWFSMa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:30:29 -0400
Received: from mail.timesys.com ([65.117.135.102]:36807 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S932424AbWFSMa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:30:27 -0400
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and 
	dynamic HZ
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Con Kolivas <kernel@kolivas.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200606192209.38403.kernel@kolivas.org>
References: <1150643426.27073.17.camel@localhost.localdomain>
	 <449580CA.2060704@gmail.com>
	 <1150660202.27073.23.camel@localhost.localdomain>
	 <200606192209.38403.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 14:31:44 +0200
Message-Id: <1150720304.27073.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 22:09 +1000, Con Kolivas wrote:
> Also suffers from:
> WARNING: "timespec_to_jiffies" [fs/fuse/fuse.ko] undefined!
> 
> Here is a fix

Doh, where is the brown paperbag shop ?

Thanks, applied.

New queue:

http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick3.patch

http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick3.patches.tar.bz2

	tglx


