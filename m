Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWA3HAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWA3HAk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 02:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWA3HAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 02:00:40 -0500
Received: from orion2.pixelized.ch ([195.190.190.13]:32712 "EHLO
	mail.pixelized.ch") by vger.kernel.org with ESMTP id S932113AbWA3HAk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 02:00:40 -0500
Message-ID: <43DDB98E.8010207@debian.org>
Date: Mon, 30 Jan 2006 08:00:30 +0100
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Al Viro <viro@ftp.linux.org.uk>, Simon Oosthoek <simon.oosthoek@ti-wmc.nl>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com> <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D9F9F9.5060501@ti-wmc.nl> <20060127133939.GU27946@ftp.linux.org.uk> <Pine.LNX.4.64.0601272043020.3192@evo.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601272043020.3192@evo.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 27 Jan 2006, Al Viro wrote:
> 
>>Bzzert.   "GPLv2 only in the context of the Linux kernel" is incompatible
>>with GPLv2 and means that resulting kernel is impossible to distribute.
> 
> 
> Indeed. The GPL (both v2 and v3) disallow restricting usage. 
> 
> So certain _code_ can be either v2 or v3 only, but you can't make that 
> decision based on how the code is used. 
> 
> So you can't license, for example, your code "udner the GPL only for the 
> Linux kernel". Trust me, some companies have actually wanted to do exactly 
> that - they wanted to distribute their code, but _only_ for the kernel 
> (and you'd not be allowed to use it for any other GPL'd project). That 
> just cannot fly. It's either GPL, or it isn't. There's no "GPL with the 
> following rules".

Not really the same case, but ...

/*
  *  linux/init/version.c
  *
  *  Copyright (C) 1992  Theodore Ts'o
  *
  *  May be freely distributed as part of Linux.
  */

ciao
	cate
