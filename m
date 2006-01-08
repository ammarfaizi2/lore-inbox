Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752610AbWAHOXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbWAHOXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 09:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbWAHOXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 09:23:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61967 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752610AbWAHOXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 09:23:38 -0500
Date: Sun, 8 Jan 2006 14:23:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] wbsd pnp suspend
Message-ID: <20060108142331.GB10927@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20060107230201.28473.19968.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107230201.28473.19968.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 12:02:01AM +0100, Pierre Ossman wrote:
> Allow the wbsd driver to use the new suspend/resume functions added to
> the PnP layer.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
