Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274544AbRJKAA0>; Wed, 10 Oct 2001 20:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRJKAAR>; Wed, 10 Oct 2001 20:00:17 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:59850 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S274544AbRJKAAE>; Wed, 10 Oct 2001 20:00:04 -0400
Date: Thu, 11 Oct 2001 01:00:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rudi Sluijtman <rudi@sluijtman.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] .version, newversion in Makefile
Message-ID: <20011011010032.H17670@flint.arm.linux.org.uk>
In-Reply-To: <200110102122.f9ALMx424058@nerys.ehv.lx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110102122.f9ALMx424058@nerys.ehv.lx>; from rudi@sluijtman.com on Wed, Oct 10, 2001 at 11:22:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 11:22:59PM +0200, Rudi Sluijtman wrote:
> Due to a change in the main Makefile the .version file is overwritten
> by a new empty one since at least 2.4.10-pre12, so the version becomes
> or remains 1 after each recompile.

There is a patch in -ac to fix this.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

