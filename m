Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVEMJbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVEMJbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 05:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVEMJbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 05:31:20 -0400
Received: from [85.8.12.41] ([85.8.12.41]:6056 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262316AbVEMJbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 05:31:19 -0400
Message-ID: <428473E5.4050605@drzeus.cx>
Date: Fri, 13 May 2005 11:31:17 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [2.6 patch] drivers/mmc/wbsd.c: possible cleanups
References: <20050513004755.GY3603@stusta.de>
In-Reply-To: <20050513004755.GY3603@stusta.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make some needlessly global code static
> - remove the unneeded global function DBG_REG
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 

This patch looks fine to me, so go ahead and apply it Russell.

Rgds
Pierre
