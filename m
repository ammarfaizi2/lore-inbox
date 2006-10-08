Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWJHVUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWJHVUZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWJHVUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:20:25 -0400
Received: from www.osadl.org ([213.239.205.134]:47807 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751474AbWJHVUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:20:24 -0400
Subject: Re: + clocksource-increase-initcall-priority.patch added to -mm
	tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160342112.3693.146.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
	 <1160294812.22911.8.camel@localhost.localdomain>
	 <1160302797.22911.37.camel@localhost.localdomain>
	 <1160319033.3693.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319234.5686.12.camel@localhost.localdomain>
	 <1160322317.3693.47.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160323127.5686.37.camel@localhost.localdomain>
	 <1160324288.3693.71.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160326363.5686.48.camel@localhost.localdomain>
	 <1160327879.3693.97.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160334205.5686.72.camel@localhost.localdomain>
	 <1160339986.3693.135.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160340722.5686.85.camel@localhost.localdomain>
	 <1160342112.3693.146.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 23:20:23 +0200
Message-Id: <1160342424.5686.102.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 14:15 -0700, Daniel Walker wrote:
> > 
> > Which one exactly? I'm not aware of a problem with the existing code at
> > all.
> 
> Clock shuffling.

What's the problem with that ? It replaces clocks. Where _is_ the
problem ?

	tglx


