Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTILAqF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 20:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbTILAqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 20:46:05 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:2706 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S261624AbTILAqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 20:46:03 -0400
Date: Fri, 12 Sep 2003 01:45:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030912004546.GB31860@mail.jlokier.co.uk>
References: <20030910210416.GA24258@mail.jlokier.co.uk> <20030910233951.Q30046@flint.arm.linux.org.uk> <20030910233720.GA25756@mail.jlokier.co.uk> <20030911010702.W30046@flint.arm.linux.org.uk> <20030911123535.GB28180@mail.jlokier.co.uk> <20030911160929.A19449@flint.arm.linux.org.uk> <20030911162510.GA29532@mail.jlokier.co.uk> <20030911175224.A20308@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911175224.A20308@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ...until we learn what kernel versions the Netwinder folks are
> running, or they kindly run the test on a new kernel.

Two of the Netwinders are running 2.4.19-rmk7-nw1, and one is running
2.2.12-19991020.

Are both of these prior to when alias pages were made uncacheable?

Thanks,
-- Jamie
