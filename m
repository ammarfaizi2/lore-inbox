Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbTJNSxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTJNSxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:53:39 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:22984 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S262351AbTJNSxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:53:11 -0400
Date: Tue, 14 Oct 2003 11:53:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@math.ut.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20031014185305.GB16614@ip68-0-152-218.tc.ph.cox.net>
References: <20031014184228.GA16614@ip68-0-152-218.tc.ph.cox.net> <Pine.GSO.4.44.0310142143480.788-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310142143480.788-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 09:44:22PM +0300, Meelis Roos wrote:
> > > linuxppc-2.4-devel too finds only 32M of RAM. 2.4.23-pre7 finds 64M (in
> > > BAT2).
> >
> > Now we're getting somewhere.  I believe that 2.4.23-pre7 should have an
> > option to display all residual data as /proc/residual (or
> > /proc/residual.gz, I forget).  Can you please enable that, and send me
> > the data there privately?  Thanks.
> 
> This is Motorola Poserstack Pro4000 (UtahII), it has no residual data,
> at least the messages say so.

Does that machine have openfirmware by chance?

-- 
Tom Rini
http://gate.crashing.org/~trini/
