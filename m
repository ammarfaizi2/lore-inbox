Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVDSHTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVDSHTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 03:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVDSHTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 03:19:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14606 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261363AbVDSHTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 03:19:32 -0400
Date: Tue, 19 Apr 2005 08:19:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: drzeus-wbsd@drzeus.cx, wbsd-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/mmc/wbsd.c: possible cleanups
Message-ID: <20050419081926.C11988@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, drzeus-wbsd@drzeus.cx,
	wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
References: <20050419024312.GW5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050419024312.GW5489@stusta.de>; from bunk@stusta.de on Tue, Apr 19, 2005 at 04:43:12AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 04:43:12AM +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make some needlessly global code static
> - remove the unneeded global function DBG_REG
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Adrian,

Please note that we're still not fully up and running with a subsitute
development infrastructure, so I'm still not in a position to seriously
start merging patches.  Please hold off until there's an official
announcement to the contary, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
