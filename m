Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbUC2M4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbUC2Mb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:31:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47247 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262909AbUC2MaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:30:16 -0500
Date: Mon, 29 Mar 2004 14:13:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Suspend development list <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]
Message-ID: <20040329121332.GH1453@openzaurus.ucw.cz>
References: <20040323233228.GK364@elf.ucw.cz> <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz> <200403250857.08920.matthias.wieser@hiasl.net> <1080247142.6679.3.camel@calvin.wpcb.org.au> <20040325222745.GE2179@elf.ucw.cz> <20040327022125.GA2174@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040327022125.GA2174@luna.mooo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > Kernel could automagically select the right one.. But I'd prefer for
> > only "non compressed" part to reach mainline for 2.6. Feature freeze
...
> You shouldn't be to extreme in you eagerness to trim things. You should
> always take in mind what would be good for the user, not only the
> developer.

We are trying to merge into stable series. "Good for developer"
takes priority here. And likely patching compression in is easier
than patching swsusp2+compression....
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

