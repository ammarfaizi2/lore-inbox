Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbVJ1UiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbVJ1UiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbVJ1UiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:38:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26898 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751682AbVJ1UiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:38:04 -0400
Date: Fri, 28 Oct 2005 21:37:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] wbsd suspend support
Message-ID: <20051028203758.GJ4464@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <20051028073622.4122.98642.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028073622.4122.98642.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 09:36:23AM +0200, Pierre Ossman wrote:
> Proper handling of suspend/resume in the wbsd driver.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

Fixed up for suspend/resume argument changes and applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
