Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVEIIxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVEIIxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 04:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVEIIxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 04:53:54 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6306 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261155AbVEIIxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 04:53:52 -0400
Date: Mon, 9 May 2005 10:53:39 +0200 (MEST)
Message-Id: <200505090853.j498rc4m007316@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@muc.de
Subject: Re: [PATCH 2.6.12-rc3-mm3] perfctr: x86 update with K8 multicore fixes
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005 03:38:51 +0200, Andi Kleen wrote:
> > I've been burned by cpu-related maps changing before. I'd rather
> > not rely on them if I can avoid them.
> 
> I don't think that's a good attitude for a in tree driver. 
> If all drivers reimplemented core architecture features
> all the time we would have a big mess. So please don't do
> this.

Ok, I'll do a followup update to eliminate this wart.

/Mikael
