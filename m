Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVDDRC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVDDRC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVDDRCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:02:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:43245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261288AbVDDRAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:00:49 -0400
Date: Mon, 4 Apr 2005 10:02:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix u32 vs. pm_message_t in arm
In-Reply-To: <20050404174923.B12975@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0504041002080.2215@ppc970.osdl.org>
References: <20050329191543.GA8309@elf.ucw.cz> <20050403113804.A921@flint.arm.linux.org.uk>
 <20050403104414.GE1357@elf.ucw.cz> <20050404174923.B12975@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Apr 2005, Russell King wrote:
> 
> Linus - is the pm.h included in sysdev.h in -rc2?

Nope. Just includes kobject.h

		Linus
