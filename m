Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbTJNSpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTJNSos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:44:48 -0400
Received: from math.ut.ee ([193.40.5.125]:1525 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262921AbTJNSoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:44:30 -0400
Date: Tue, 14 Oct 2003 21:44:22 +0300 (EEST)
From: Meelis Roos <mroos@math.ut.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
In-Reply-To: <20031014184228.GA16614@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.GSO.4.44.0310142143480.788-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > linuxppc-2.4-devel too finds only 32M of RAM. 2.4.23-pre7 finds 64M (in
> > BAT2).
>
> Now we're getting somewhere.  I believe that 2.4.23-pre7 should have an
> option to display all residual data as /proc/residual (or
> /proc/residual.gz, I forget).  Can you please enable that, and send me
> the data there privately?  Thanks.

This is Motorola Poserstack Pro4000 (UtahII), it has no residual data,
at least the messages say so.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/

