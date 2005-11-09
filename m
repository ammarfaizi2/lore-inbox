Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbVKIXfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbVKIXfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbVKIXfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:35:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47112 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751588AbVKIXfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:35:19 -0500
Date: Wed, 9 Nov 2005 23:35:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use __devexit_p in wbsd
Message-ID: <20051109233509.GC25101@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <20051107070458.6640.83631.stgit@poseidon.drzeus.cx> <20051108231809.GG13357@flint.arm.linux.org.uk> <437134AE.5060303@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437134AE.5060303@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 12:28:46AM +0100, Pierre Ossman wrote:
> Sorry about that. Improper patch ordering on my part. Here's one where 
> it's applied before the suspend stuff.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
