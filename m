Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268468AbUIWNxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268468AbUIWNxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268467AbUIWNxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:53:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25606 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268468AbUIWNwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:52:31 -0400
Date: Thu, 23 Sep 2004 14:52:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc2-mm2] [m32r] Trivial fix of smc91x.h
Message-ID: <20040923145226.A24734@flint.arm.linux.org.uk>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040923.224854.582763130.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040923.224854.582763130.takata.hirokazu@renesas.com>; from takata@linux-m32r.org on Thu, Sep 23, 2004 at 10:48:54PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 10:48:54PM +0900, Hirokazu Takata wrote:
> Hello,
> 
> Here is a patch to fix smc91x.h for m32r.
> Please apply.

Please copy smc91x patches to nico@cam.org.  He looks after this driver
and needs to review any changes to it.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
