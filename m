Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTJTUdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJTUdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:33:41 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:5586 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id S262665AbTJTUdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:33:40 -0400
Date: Mon, 20 Oct 2003 13:33:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20031020203338.GJ6062@ip68-0-152-218.tc.ph.cox.net>
References: <20031014232511.GA17741@ip68-0-152-218.tc.ph.cox.net> <Pine.GSO.4.44.0310201655210.18000-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310201655210.18000-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 04:55:39PM +0300, Meelis Roos wrote:
> > Can you apply the following patch (2.6)?  I'm expecting it to print out that
> > it hard-codes to 32mb.
> 
> > +		puts("Hard-coded\n");
> 
> Yes, hard-coded.

Okay.  Can you give the linuxppc-2.5 repo a shot on this machine?  It's
at bk://ppc.bkbits.net/linuxppc-2.5 and
rsync://source.mvista.com/linuxppc-2.5, for reference.  Let me know if
it still boots at least and if it finds 64MB of memory again, it
should..

-- 
Tom Rini
http://gate.crashing.org/~trini/
