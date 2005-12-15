Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVLOQYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVLOQYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVLOQYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:24:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24590 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750798AbVLOQYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:24:18 -0500
Date: Thu, 15 Dec 2005 16:24:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, wbsd-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/3] wbsd: make use of ARRAY_SIZE() macro
Message-ID: <20051215162400.GE6211@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
References: <20051215053933.125918000.dtor_core@ameritech.net> <20051215054444.854564000.dtor_core@ameritech.net> <43A19557.1070605@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A19557.1070605@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 05:09:59PM +0100, Pierre Ossman wrote:
> Dmitry Torokhov wrote:
> > wbsd: make use of ARRAY_SIZE() macro
> >
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > ---
> >
> >   
> 
> Acked-by: Pierre Ossman <drzeus@drzeus.cx>
> 
> (Provided it's fixed to come before the lindent patch.)

Ok, I've queued up these two patches and fixed this one to apply.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
