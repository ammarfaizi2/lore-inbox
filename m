Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268641AbUIQJdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268641AbUIQJdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 05:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268648AbUIQJdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 05:33:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53772 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268641AbUIQJdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 05:33:38 -0400
Date: Fri, 17 Sep 2004 10:33:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Covici <covici@ccs.covici.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with multitech 4 port serial card under 2.4.x and 2.6.x
Message-ID: <20040917103322.A21199@flint.arm.linux.org.uk>
Mail-Followup-To: John Covici <covici@ccs.covici.com>,
	linux-kernel@vger.kernel.org
References: <m3656di76l.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3656di76l.fsf@ccs.covici.com>; from covici@ccs.covici.com on Fri, Sep 17, 2004 at 05:19:30AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 05:19:30AM -0400, John Covici wrote:
> I have had problems with the multitech 4 port serial card under both
> the 2.4 and the 2.6 Linux kernels.

You don't say which 2.6 kernel.  Support for these UARTs has only
recently been merged - you'll find it in 2.6.9-rc2 kernels.

Unfortunately I don't recall if it's in 2.6.9-rc1 or not.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
