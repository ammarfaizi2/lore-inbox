Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWAHOXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWAHOXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 09:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbWAHOXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 09:23:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60943 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750729AbWAHOXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 09:23:25 -0500
Date: Sun, 8 Jan 2006 14:23:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Support MMC version 4 cards.
Message-ID: <20060108142318.GA10927@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20060108114846.4507.9475.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108114846.4507.9475.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 12:48:47PM +0100, Pierre Ossman wrote:
> Version 4 of the MMC specification increased the version number of the
> CID structure. None of the fields changed though so the only required
> change is adding '4' to the approved list.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
