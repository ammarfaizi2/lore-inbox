Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263823AbTCVT3A>; Sat, 22 Mar 2003 14:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263831AbTCVT3A>; Sat, 22 Mar 2003 14:29:00 -0500
Received: from main.gmane.org ([80.91.224.249]:12219 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S263823AbTCVT27>;
	Sat, 22 Mar 2003 14:28:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: reiserfs oops [2.5.65]
Date: Sat, 22 Mar 2003 14:36:07 -0500
Message-ID: <3E7CBB27.8090506@myrealbox.com>
References: <20030319141048.GA19361@suse.de>	<20030320112559.A12732@namesys.com>	<20030320132409.GA19042@suse.de>	<20030320165941.0d19d09d.akpm@digeo.com>	<20030320231335.GB4638@suse.de> <20030320153427.6265e864.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
[SNIP]
> 
> I've done some 2.5.xyz work on kmsgdump (dump kernel messages to
> floppy).  I'll try to get back to it soon.
> 

Thank you!  That'd be a god-send for those of us w/o serial 
ports and who have very cramped hands from hand-copying 
panics :-D.  Frankly, I can't imagine why something a simple 
as this isn't in the kernel.  Technically, it isn't a 
debugger, so I don't think it violates Linus' "No Kernel 
Debuggers in the Kernel" rule.

Cheers,
Nicholas


