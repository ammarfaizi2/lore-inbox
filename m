Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbUAOVSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbUAOVSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:18:18 -0500
Received: from relay.pair.com ([209.68.1.20]:64008 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S263441AbUAOVSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:18:04 -0500
X-pair-Authenticated: 68.42.66.6
Subject: Re: Laptops & CPU frequency
From: Daniel Gryniewicz <dang@fprintf.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Robert Love <rml@ximian.com>, Dave Jones <davej@redhat.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040115204257.GG467@openzaurus.ucw.cz>
References: <20040111025623.GA19890@ncsu.edu>
	 <1073791061.1663.77.camel@localhost>
	 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
	 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
	 <1073841200.1153.0.camel@localhost>
	 <E1AfjdT-0008OH-00@chiark.greenend.org.uk>
	 <1073843690.1153.12.camel@localhost> <20040114045945.GB23845@redhat.com>
	 <1074107508.4549.10.camel@localhost> <1074107842.1153.959.camel@localhost>
	 <20040115204257.GG467@openzaurus.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1074201480.4877.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 16:18:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-15 at 15:42, Pavel Machek wrote:
> People are designing machines where battery can't provide
> enough ampers for cpu in high-power mode. If speedstep machines
> have same problem, SMM is actually right thing to do.

Okay, makes sense.  I did wonder how they could run an Athlon XP off of
battery...  Next time, maybe a Pentium-M. :)
-- 
Daniel Gryniewicz <dang@fprintf.net>
