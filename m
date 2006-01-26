Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWAZTWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWAZTWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWAZTWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:22:36 -0500
Received: from 8.ctyme.com ([69.50.231.8]:35716 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S964848AbWAZTWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:22:33 -0500
Message-ID: <43D92175.6010804@perkel.com>
Date: Thu, 26 Jan 2006 11:22:29 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: Diego Calleja <diegocg@gmail.com>, Paul Jakma <paul@clubi.ie>,
       torvalds@osdl.org, linux-os@analogic.com, mrmacman_g4@mac.com,
       jmerkey@wolfmountaingroup.com, pmclean@cs.ubishops.ca,
       shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D114A8.4030900@wolfmountaingroup.com> <20060120111103.2ee5b531@dxpl.pdx.osdl.net> <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com> <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <Pine.LNX.4.64.0601261757320.3920@sheen.jakma.org> <20060126195323.d553a4b8.diegocg@gmail.com> <Pine.LNX.4.64.0601261255430.17225@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0601261255430.17225@turbotaz.ourhouse>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be some confusion about licensing. I'm just going to see 
if I can define the problem and the issues.

First - some people think all of Linux is under GPLv2 - but some people 
seem to think it's really GPLv2 or later. That needs to be resolved. Can 
different parts of Linux be controlled by multiple licenses. If so - 
that could create confusion because someone would have to agree to all 
the licenses within Linux in order to use it. The alternative is to say 
it's all GPLv2 and exclude GPLv3 from inclusion. Do we want to do that.

Second - is GPLv3 Linux compatible. If Linux were to start over today 
would it pick GPLv2 or GPLv3? Is there anything in GPLv3 that is not 
Linux compatible. I would at least like to see GPLv3 (final draft) to be 
100% Linux compatible.

Suppose GPLv3 were Linux compatible and many existing authors and new 
authors adopted GPLv3 but dead authors and some stubborn people and 
people who can't be found are still at GPLv2. Lets also assume that 
critical parts of Linux code are licensed in both worlds. What dos that 
mean? Does that mean that GPLv3 prevails?

This is something that might be worth doing some serious legal work on 
because if we do it wrong it could bite us hard in the future. But I 
want to try to properly raise the question here so that we all at least 
understand the problem.

My 2 centz ....

