Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVCITBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVCITBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVCIS7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:59:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:21706 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262181AbVCIS7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:59:23 -0500
Date: Wed, 9 Mar 2005 10:58:45 -0800
From: Greg KH <greg@kroah.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org,
       gjaeger@sysgo.com
Subject: Re: [patch 3/5] ppc32: Compilation fixes for Ebony, Luan and Ocotea
Message-ID: <20050309185845.GD27268@kroah.com>
References: <200503042117.j24LHHhN017970@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503042117.j24LHHhN017970@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:16:56PM -0800, akpm@osdl.org wrote:
> 
> From: Matt Porter <mporter@kernel.crashing.org>
> 
> this patch fixes the problem, that the current kernel (linux-2.6.11-rc5)
> could not be compiled, when "support for early boot texts over serial port"
> (CONFIG_SERIAL_TEXT_DEBUG=y) is active.
> 
> Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>
> Signed-off-by: Matt Porter <mporter@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Added to the -stable queue, thanks.

greg k-h

