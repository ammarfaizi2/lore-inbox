Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268254AbTBNKDv>; Fri, 14 Feb 2003 05:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268335AbTBNKDv>; Fri, 14 Feb 2003 05:03:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49425 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268254AbTBNKDu>; Fri, 14 Feb 2003 05:03:50 -0500
Date: Fri, 14 Feb 2003 10:13:39 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Consolidate signal numbers
Message-ID: <20030214101339.A3825@flint.arm.linux.org.uk>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>
References: <20030214171953.10a7d71e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030214171953.10a7d71e.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Fri, Feb 14, 2003 at 05:19:53PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 05:19:53PM +1100, Stephen Rothwell wrote:
> I intend to try to consolidate some more of the signal code over time,
> this is just a small beginning.

It would be a good idea to let the dust settle after the recent set of
signal changes before making any inroads into this.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

