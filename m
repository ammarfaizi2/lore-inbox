Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVILTUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVILTUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVILTUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:20:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:64203 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750919AbVILTUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:20:50 -0400
Date: Mon, 12 Sep 2005 20:20:49 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] 2.6.13-git12-bird1
Message-ID: <20050912192049.GO25261@ZenIV.linux.org.uk>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912191744.GN25261@ZenIV.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 08:17:44PM +0100, Al Viro wrote:
> Patchset moved to -git12.  News:
> 	* playing catch-up with spinlock changes (m68k build got broken)
> 	* playing catch-up with kbuild changes (arm, uml)
> 	* usual assorted build fixes
> 	* assorted sparse annotations
> 	* beginning of endianness annotations merge: RPC patches from Alexey
> 	* beginning of linux/irq.h work
> 
> Patch is in usual place.  Patch itself is patch-2.6.13-git12-bird1.bz2,
> splitup is in patchset/, logs in logs/*/*log21c.
> 
> Shortlog follows.

... Actually, that would be "Shortlog of additions since the last posted
version".
