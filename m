Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbTCTR53>; Thu, 20 Mar 2003 12:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbTCTR53>; Thu, 20 Mar 2003 12:57:29 -0500
Received: from havoc.daloft.com ([64.213.145.173]:59603 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261628AbTCTR51>;
	Thu, 20 Mar 2003 12:57:27 -0500
Date: Thu, 20 Mar 2003 13:08:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: george cewe <gcewe@copper.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: submission of CAN driver for i82527 chip
Message-ID: <20030320180823.GC8256@gtf.org>
References: <005501c2ef09$c6f93480$54491cd8@CEVE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005501c2ef09$c6f93480$54491cd8@CEVE>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 12:54:36PM -0500, george cewe wrote:
> Dear Kernel Maintainer;
> 
> Please find enclosed 2 files of a driver for Intel 82527 CAN Controller,
> This driver is a simplified version of 'ocan' driver by Allesandro Rubini.
> 
> 'jcan' is a character driver for kernel 2.4 and up, I inserted it in
> linux_root/drivers/char directory.
> I tested it on embedded MPC823 platform, but it should be running on other
> platforms as well.

Marcelo bounced this to me...  I've reviewed it and have some minor
cleanups and fixes for it.  I'll send when I get home.

Mostly it looks ok...

	Jeff



