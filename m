Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVADNJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVADNJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVADNJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:09:23 -0500
Received: from holomorphy.com ([207.189.100.168]:26246 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261622AbVADNJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:09:03 -0500
Date: Tue, 4 Jan 2005 04:57:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104125738.GC2708@holomorphy.com>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103134727.GA2980@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 02:24:12PM +0100, Diego Calleja wrote:
>> 2.6 will stop having small issues in each release until 2.7 is forked just
>> like 2.4 broke things until 2.5 was forked. The difference IMO
>> is that linux development now avoids things like the unstability which the
>> 2.4.10 changes caused and things like the fs corruption bugs we saw in 2.4

On Mon, Jan 03, 2005 at 02:47:27PM +0100, Adrian Bunk wrote:
> The 2.6.9 -> 2.6.10 patch is 28 MB, and while the changes that went into 
> 2.4 were limited since the most invasive patches were postponed for 2.5, 
> now _all_ patches go into 2.6 .
> Yes, -mm gives a bit more testing coverage, but it doesn't seem to be 
> enough for this vast amount of changes.

No amount of testing coverage will ever suffice. You're trying to
empirically establish the nonexistence of something, which is only
possible to repudiate, and never to verify.


-- wli
