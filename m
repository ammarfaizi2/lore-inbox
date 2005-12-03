Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVLCW6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVLCW6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVLCW6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:58:18 -0500
Received: from mail.gmx.de ([213.165.64.20]:52660 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751301AbVLCW6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:58:17 -0500
X-Authenticated: #428038
Date: Sat, 3 Dec 2005 23:58:15 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203225815.GH25722@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <1133620264.2171.14.camel@localhost.localdomain> <20051203193538.GM31395@stusta.de> <1133639835.16836.24.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133639835.16836.24.camel@mindpipe>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Dec 2005, Lee Revell wrote:

> You seem to be saying that the current development model is unacceptable
> for users for whom older kernel work just fine, and the main risk in
> upgrading is regression.  But the new development model is clearly
> needed for those users whose needs are not met by the old kernel, say
> due to unacceptable soft RT performance or unsupported hardware.
> 
> But it's wrong to try to evenly balance the needs of these two classes
> of users, because the first class has another option - they can stick
> with the old kernel that works for them.  The second class of users has

The point that just escaped you as the motivation for this thread was
the availability of security (or other critical) fixes for older
kernels. It would all be fine if, say, the fix for CVE-2004-2492 were
available for those who find 2.6.8 works for them (the fix went into
2.6.14 BTW), and the concern is the development model isn't fit to
accomodate needs like this.

-- 
Matthias Andree
