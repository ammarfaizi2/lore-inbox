Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWGLLiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWGLLiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWGLLiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:38:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59915 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751270AbWGLLh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:37:59 -0400
Date: Wed, 12 Jul 2006 12:37:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix compilation on arm in -rc1-git
Message-ID: <20060712113753.GB7908@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net,
	kernel list <linux-kernel@vger.kernel.org>
References: <20060712111157.GA1978@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712111157.GA1978@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 01:11:57PM +0200, Pavel Machek wrote:
> After latest git update, I was getting compile errors until doing:

I've sent a better fix to Linus, Andrew, lkml, etc yesterday evening -
part of the "RFC: cleaning up the in-kernel headers" thread.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
