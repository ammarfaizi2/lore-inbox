Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbUAOVJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUAOVJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:09:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36331 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263726AbUAOVIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:08:01 -0500
Date: Thu, 15 Jan 2004 21:42:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Robert Love <rml@ximian.com>
Cc: Daniel Gryniewicz <dang@fprintf.net>, Dave Jones <davej@redhat.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Laptops & CPU frequency
Message-ID: <20040115204257.GG467@openzaurus.ucw.cz>
References: <20040111025623.GA19890@ncsu.edu> <1073791061.1663.77.camel@localhost> <E1Afj2b-0004QN-00@chiark.greenend.org.uk> <E1Afj2b-0004QN-00@chiark.greenend.org.uk> <1073841200.1153.0.camel@localhost> <E1AfjdT-0008OH-00@chiark.greenend.org.uk> <1073843690.1153.12.camel@localhost> <20040114045945.GB23845@redhat.com> <1074107508.4549.10.camel@localhost> <1074107842.1153.959.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074107842.1153.959.camel@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have an athlon-xp laptop (HP pavilion ze4500) with powernow that
> > definitely goes into low power mode when the plug is pulled.  The screen
> > goes dark, and everything slows down.
> 
> Dave did not mean that the other power management schemes cannot do the
> automatic reduction on loss of AC, just that there is no SMM/BIOS hacks
> to do it automatically.

People are designing machines where battery can't provide
enough ampers for cpu in high-power mode. If speedstep machines
have same problem, SMM is actually right thing to do.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

