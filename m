Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945909AbWANBDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945909AbWANBDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945911AbWANBDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:03:46 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:31407 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1945909AbWANBDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:03:46 -0500
Date: Fri, 13 Jan 2006 17:13:33 -0800
From: thockin@hockin.org
To: Andreas Steinmetz <ast@domdv.de>
Cc: David Lang <dlang@digitalinsight.com>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
Message-ID: <20060114011333.GA9371@hockin.org>
References: <1137190698.2536.65.camel@localhost.localdomain> <Pine.LNX.4.62.0601131448150.9821@qynat.qvtvafvgr.pbz> <43C848C7.1070701@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C848C7.1070701@domdv.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 01:41:43AM +0100, Andreas Steinmetz wrote:
> > more precisely 1/4 KW Hour / day
> > 
> > $0.01 - $0.02/day (I had to lookup the current rates)
> > 
> > they probably won't notice.
> 
> Well, wait until there's AMD based dual core x86_64 laptops out there
> (this email being written on a single core x86_64 one). I can already
> see the faces of the unhappy future owners being told "use idle=poll"
> when on battery and anyway going deaf by fan noise.

Yeah, and then multiply that cost by a few tens of thousands of servers.

idle=poll is a hack at best.
