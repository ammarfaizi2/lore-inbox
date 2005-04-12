Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbVDLVR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbVDLVR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVDLVOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:14:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32275 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262992AbVDLVMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:12:23 -0400
Date: Tue, 12 Apr 2005 22:12:18 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: incoming
Message-ID: <20050412221218.D11984@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050412032322.72d73771.akpm@osdl.org> <20050412215526.B11984@flint.arm.linux.org.uk> <20050412140800.43d45d01.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050412140800.43d45d01.akpm@osdl.org>; from akpm@osdl.org on Tue, Apr 12, 2005 at 02:08:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 02:08:00PM -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > I don't see a patch which adds linux/pm.h to linux/sysdev.h, which is
> >  required to fix ARM builds in -rc2 and onwards kernels.
> 
> That fix is buried in [patch 105/198]

Great, thanks.  I must have missed it, sorry.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
