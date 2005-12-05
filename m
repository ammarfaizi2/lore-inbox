Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbVLEKB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVLEKB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 05:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVLEKB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 05:01:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29962 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751323AbVLEKB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 05:01:58 -0500
Date: Mon, 5 Dec 2005 10:01:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Proper check of SCR error code
Message-ID: <20051205100152.GA8863@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20051204140019.21469.97634.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204140019.21469.97634.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 03:00:19PM +0100, Pierre Ossman wrote:
> The routine reading the SCR wasn't paying proper attention to the error
> codes returned from the driver.

Applied, thanks Pierre.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
