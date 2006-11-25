Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967204AbWKYUy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967204AbWKYUy4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967205AbWKYUyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:54:55 -0500
Received: from 1wt.eu ([62.212.114.60]:46084 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S967204AbWKYUyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:54:55 -0500
Date: Sat, 25 Nov 2006 22:45:54 +0100
From: Willy Tarreau <w@1wt.eu>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4] arm: incorrect use of "&&" instead of "&"
Message-ID: <20061125214554.GA6155@1wt.eu>
References: <20061125213047.GA5950@1wt.eu> <20061125204830.GC13089@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125204830.GC13089@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 08:48:30PM +0000, Russell King wrote:
> On Sat, Nov 25, 2006 at 10:30:47PM +0100, Willy Tarreau wrote:
> > I'm about to merge this fix into 2.4. It's already been fixed in 2.6.
> > Do you have any objection ?
> 
> No objection - please merge.

done.

> > BTW, I have two email addresses for you, the one in the MAINTAINERS file
> > and the one you use on LKML. Which one do you prefer ? Just in case, I've
> > used both.
> 
> Both reach me, but I'd perfer rmk+kernel please.

OK, that's noted.

Thanks !
Willy

