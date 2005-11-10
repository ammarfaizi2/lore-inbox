Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVKJNJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVKJNJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVKJNJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:09:57 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:33726 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750831AbVKJNJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:09:56 -0500
Date: Thu, 10 Nov 2005 22:09:15 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [patch] Cleanup bootmem allocator and fix alloc_bootmem_low
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051108184505.GB3733@localhost.localdomain>
References: <20051108224621.7062.Y-GOTO@jp.fujitsu.com> <20051108184505.GB3733@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.051
Message-Id: <20051110220306.023C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


> Yes, it was on top of the latest git as of the patch creation.
> 
> > I tried it on my ia64 Tiger4 with NUMA emulation.
> > This emulation had worked well so far.
> > 
> > But, 2.6.14-git11 doen't boot even if your patch is not used.
> > (Probably, it is caused by changing efi_map walker.)
> > 
> > And I can't use our big true NUMA machine now.
> > It is used by other person. So, I have to reserve it to use again.
> > 
> > If I can test it, I'll notify about it ASAP.
> 
> 'Appreciate the feedback.  Do let me know how it goes.

My NUMA emulation works well again. And your patch works on it too. :-)

Bye.

-- 
Yasunori Goto 


