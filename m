Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967203AbWKYUsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967203AbWKYUsi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967204AbWKYUsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:48:38 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:60941 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S967203AbWKYUsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:48:37 -0500
Date: Sat, 25 Nov 2006 20:48:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4] arm: incorrect use of "&&" instead of "&"
Message-ID: <20061125204830.GC13089@flint.arm.linux.org.uk>
Mail-Followup-To: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
References: <20061125213047.GA5950@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125213047.GA5950@1wt.eu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 10:30:47PM +0100, Willy Tarreau wrote:
> I'm about to merge this fix into 2.4. It's already been fixed in 2.6.
> Do you have any objection ?

No objection - please merge.

> BTW, I have two email addresses for you, the one in the MAINTAINERS file
> and the one you use on LKML. Which one do you prefer ? Just in case, I've
> used both.

Both reach me, but I'd perfer rmk+kernel please.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
