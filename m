Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268984AbUIMVfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268984AbUIMVfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUIMVfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:35:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9741 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268984AbUIMVeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:34:24 -0400
Date: Mon, 13 Sep 2004 22:34:18 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix allnoconfig on arm with small tweak to kconfig?
Message-ID: <20040913223418.C4658@flint.arm.linux.org.uk>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <414551FD.4020701@kegel.com> <20040913091534.B27423@flint.arm.linux.org.uk> <4145BB30.60309@kegel.com> <20040913195119.B4658@flint.arm.linux.org.uk> <20040913192900.GC4317@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040913192900.GC4317@MAIL.13thfloor.at>; from herbert@13thfloor.at on Mon, Sep 13, 2004 at 09:29:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 09:29:00PM +0200, Herbert Poetzl wrote:
> if this isn't in _your_ interest, then maybe some specific
> (considered representative) system defaults can be used instead

The RiscPC machine is a representative set of defaults.  It just
doesn't happen to work with all*config because all*config makes
no sense.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
