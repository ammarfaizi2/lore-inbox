Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVEAXMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVEAXMT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 19:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVEAXMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 19:12:18 -0400
Received: from 70-57-132-14.albq.qwest.net ([70.57.132.14]:3046 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261369AbVEAXMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 19:12:15 -0400
Date: Sun, 1 May 2005 17:13:23 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] kernel/irq/manage.c: remove the empty set_irq_info()
In-Reply-To: <20050501210011.GY3592@stusta.de>
Message-ID: <Pine.LNX.4.61.0505011710400.12903@montezuma.fsmlabs.com>
References: <20050501210011.GY3592@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2005, Adrian Bunk wrote:

> I do still not like an empty global function.
> 
> All other cases are already handled by static inline's, so let's do the 
> same with this one.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Thanks Adrian
