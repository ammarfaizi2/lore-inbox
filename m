Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbSAEUaE>; Sat, 5 Jan 2002 15:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282861AbSAEU3z>; Sat, 5 Jan 2002 15:29:55 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:55037 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S282845AbSAEU3j>; Sat, 5 Jan 2002 15:29:39 -0500
Date: Sat, 5 Jan 2002 15:28:58 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200201052028.g05KSwd27459@devserv.devel.redhat.com>
To: adam@yggdrasil.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.2-pre8/drivers/sound compilation fixes: MINOR-->minor
In-Reply-To: <mailman.1010231581.875.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1010231581.875.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Doing a global replace of "MINOR(" with "minor(" in all
> .c files in linux/drivers/sound allows all of the sound drivers
> to compile (at least as modules on x86).  [...]

You did not change ymfpci, why? Linus fixed it already?

-- Pete
