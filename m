Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVICPqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVICPqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 11:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVICPqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 11:46:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51209 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751226AbVICPqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 11:46:08 -0400
Date: Sat, 3 Sep 2005 16:46:00 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ios for mmc chip select
Message-ID: <20050903164600.C4416@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <4312EDE6.7090603@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4312EDE6.7090603@drzeus.cx>; from drzeus-list@drzeus.cx on Mon, Aug 29, 2005 at 01:13:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 01:13:42PM +0200, Pierre Ossman wrote:
> Adds a new ios for setting the chip select pin on MMC cards. Needed on
> SD controllers which use this pin for other things and therefore cannot
> have it pulled high at all times.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
