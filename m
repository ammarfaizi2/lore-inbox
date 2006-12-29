Return-Path: <linux-kernel-owner+w=401wt.eu-S1755051AbWL2QB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbWL2QB7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 11:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755048AbWL2QB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 11:01:59 -0500
Received: from xenotime.net ([66.160.160.81]:41617 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752139AbWL2QB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 11:01:58 -0500
Date: Fri, 29 Dec 2006 07:50:16 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: yunfeng zhang <zyf.zeroos@gmail.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 2.6.16.29 1/1] memory: enhance Linux swap subsystem
Message-Id: <20061229075016.62f47ec9.rdunlap@xenotime.net>
In-Reply-To: <20061229091551.GC3543@elf.ucw.cz>
References: <4df04b840612260018u4be268cod9886edefd25c3a@mail.gmail.com>
	<20061227184421.GE4088@ucw.cz>
	<4df04b840612282245x67b9f821ja9141f324f08f8df@mail.gmail.com>
	<20061229091551.GC3543@elf.ucw.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 10:15:51 +0100 Pavel Machek wrote:

> On Fri 2006-12-29 14:45:33, yunfeng zhang wrote:
> > I've re-published my work on quilt, sorry.
> 
> Your patch is still wordwrapped.
> 
> Do not cc linus on non-final version of the patch.
> 
> Patch should be against latest kernel.
> 
> Patch should have changelog and signed off by.
> 
> Why the change? Do you gain 5% on kernel compile on 20MB box?

+ Don't leave the entire email inline if you are not going to
  comment on it inline.

---
~Randy
