Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVCITVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVCITVD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVCITRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:17:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:25802 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262188AbVCIS7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:59:32 -0500
Date: Wed, 9 Mar 2005 10:59:04 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@freescale.com>
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: trivial fix for e500 oprofile build
Message-ID: <20050309185904.GF27268@kroah.com>
References: <Pine.LNX.4.61.0503041303290.18551@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503041303290.18551@blarg.somerset.sps.mot.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:09:18PM -0600, Kumar Gala wrote:
> Andrew, Greg
> 
> Here is a patch for the new 2.6.11 release tree and for Linus.
> 
> Fix for trivial fix for 2.6.11 oprofile compilation on e500 based ppc.
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

Added to the -stable queue, thanks.

greg k-h

