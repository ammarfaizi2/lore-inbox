Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268059AbTBWLM6>; Sun, 23 Feb 2003 06:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTBWLM6>; Sun, 23 Feb 2003 06:12:58 -0500
Received: from mailc.telia.com ([194.22.190.4]:39674 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S268059AbTBWLM5>;
	Sun, 23 Feb 2003 06:12:57 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Date: Sun, 23 Feb 2003 12:22:59 +0100 (CET)
Message-Id: <20030223.122259.03158704.cfmd@swipnet.se>
To: mbligh@aracnet.com
Cc: wli@holomorphy.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
From: Magnus Danielson <cfmd@swipnet.se>
In-Reply-To: <316510000.1045961436@flay>
References: <20030222083810.GA4170@gtf.org>
	<20030222221820.GI10401@holomorphy.com>
	<316510000.1045961436@flay>
X-Mailer: Mew version 3.1 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Minutes from Feb 21 LSE Call
Date: Sat, 22 Feb 2003 16:50:36 -0800

> > On Sat, Feb 22, 2003 at 03:38:10AM -0500, Jeff Garzik wrote:
> >> ia32 big iron.  sigh.  I think that's so unfortunately in a number
> >> of ways, but the main reason, of course, is that highmem is evil :)
> 
> One phrase ... "price:performance ratio". That's all it's about.
> The only thing that will kill 32-bit big iron is the availability of 
> cheap 64 bit chips. It's a free-market economy.
> 
> It's ugly to program, but it's cheap, and it works.

Not all heavy-duty problems die for 64 bit, but fit nicely into 32 bit.
There is however different 32-bit architectures for which it fit more or less
nicely into. SIMD may or may not give the boost just as 64 bit in itself.
This is just like clustering vs. SMP, it depends on the application.

Cheers,
Magnus
