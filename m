Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVEMJ7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVEMJ7G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 05:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVEMJ7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 05:59:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63759 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262324AbVEMJ6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 05:58:54 -0400
Date: Fri, 13 May 2005 10:58:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, drzeus-wbsd@drzeus.cx,
       wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/mmc/wbsd.c: possible cleanups
Message-ID: <20050513105847.A4143@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, drzeus-wbsd@drzeus.cx,
	wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
References: <20050513004755.GY3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050513004755.GY3603@stusta.de>; from bunk@stusta.de on Fri, May 13, 2005 at 02:47:55AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 02:47:55AM +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make some needlessly global code static
> - remove the unneeded global function DBG_REG
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

I'm not applying this patch because it conflicts with other changes from
Pierre which have already been merged.  Please re-send after Linus returns
and this driver has been updated in mainline.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
