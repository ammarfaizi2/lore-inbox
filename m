Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268704AbUIQLtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268704AbUIQLtj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268708AbUIQLti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:49:38 -0400
Received: from dpvc-162-83-93-166.fred.east.verizon.net ([162.83.93.166]:49038
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S268704AbUIQLth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:49:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16714.53061.907750.493001@ccs.covici.com>
Date: Fri, 17 Sep 2004 07:49:25 -0400
From: John covici <covici@ccs.covici.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: John Covici <covici@ccs.covici.com>, linux-kernel@vger.kernel.org
Subject: Re: problems with multitech 4 port serial card under 2.4.x and 2.6.x
In-Reply-To: <20040917103322.A21199@flint.arm.linux.org.uk>
References: <m3656di76l.fsf@ccs.covici.com>
	<20040917103322.A21199@flint.arm.linux.org.uk>
X-Mailer: VM 7.17 under Emacs 21.3.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found it in the changelog -- thanks much.  I wonder why the board
would freak out the apic stuff?

on Friday 09/17/2004 Russell King(rmk+lkml@arm.linux.org.uk) wrote
 > On Fri, Sep 17, 2004 at 05:19:30AM -0400, John Covici wrote:
 > > I have had problems with the multitech 4 port serial card under both
 > > the 2.4 and the 2.6 Linux kernels.
 > 
 > You don't say which 2.6 kernel.  Support for these UARTs has only
 > recently been merged - you'll find it in 2.6.9-rc2 kernels.
 > 
 > Unfortunately I don't recall if it's in 2.6.9-rc1 or not.
 > 
 > -- 
 > Russell King
 >  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 >  maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
 >                  2.6 Serial core

-- 
         John Covici
         covici@ccs.covici.com
