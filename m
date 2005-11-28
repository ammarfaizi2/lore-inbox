Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVK1VBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVK1VBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVK1VBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:01:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25363 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751264AbVK1VBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:01:19 -0500
Date: Mon, 28 Nov 2005 21:01:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Fix protocol errors
Message-ID: <20051128210112.GC14557@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20051128085404.4852.40271.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128085404.4852.40271.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 09:54:04AM +0100, Pierre Ossman wrote:
> A review against MMC/SD specifications found some errors in the current
> implementation.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

Thanks Pierre, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
