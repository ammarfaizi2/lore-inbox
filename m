Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWDIQ5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWDIQ5N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 12:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWDIQ5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 12:57:13 -0400
Received: from waste.org ([64.81.244.121]:43691 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750818AbWDIQ5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 12:57:12 -0400
Date: Sun, 9 Apr 2006 11:56:16 -0500
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/random.c: unexport secure_ipv6_port_ephemeral
Message-ID: <20060409165616.GW15445@waste.org>
References: <20060409155822.GI8454@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060409155822.GI8454@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 05:58:22PM +0200, Adrian Bunk wrote:
> This patch removes the unused EXPORT_SYMBOL(secure_ipv6_port_ephemeral).

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Matt Mackall <mpm@selenic.com>

Adrian appears to be correct that this doesn't break modular ipv6.
-- 
Mathematics is the supreme nostalgia of our time.
