Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVBJGIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVBJGIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 01:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVBJGIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 01:08:52 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:31115 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S262027AbVBJGIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 01:08:47 -0500
Message-ID: <420AFA54.9000204@andrew.cmu.edu>
Date: Thu, 10 Feb 2005 01:08:20 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Larry McVoy <lm@bitmover.com>, Nicolas Pitre <nico@cam.org>,
       Jon Smirl <jonsmirl@gmail.com>, tytso@mit.edu,
       Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
References: <20050209184629.GR22893@bitmover.com> <Pine.LNX.4.61.0502091513060.7836@localhost.localdomain> <20050209235312.GA25351@bitmover.com> <Pine.LNX.4.61.0502100109050.6118@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0502100109050.6118@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman, please give up on importing 100% of the history.  There's no 
point arguing something if you already know what the other person's 
answer will be.  Larry will not change his mind under any currently 
foreseeable circumstances.  Yes, there is "meta-data lockin" whether 
anyone at BitMover will admit it or not, but no that will not change.

Linux survived in the past without much history, and if a replacement 
arrives, people can make the switch even with a degraded history.  In 
very little time that switchover would seem as remote as the pre-BK 
times are now.

Right now I don't see why its necessary to track the Linux repo in 100% 
detail for SCM development; There are plenty of other big trees to test 
on if you need every detail.  Time spent tracking Linux are probably 
better spent improving an alternative SCM, most of which have plenty of 
wishlist items awaiting developers.  For kernel development, yes it's 
painful for SCM developers or purists, but you can still work just fine 
with patches.  Maintainers certainly benefit from BK, but for developers 
on the leaves of the hierarchy there's not that much difference.

  - Jim Bruce
