Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWA0HDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWA0HDa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWA0HDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:03:30 -0500
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:16351 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751211AbWA0HD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:03:29 -0500
Message-ID: <BAYC1-PASMTP05B0F8D6E29A63544324F8AE140@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Fri, 27 Jan 2006 01:58:11 -0500
From: sean <seanlkml@sympatico.ca>
To: Marc Perkel <marc@perkel.com>
Cc: chase.venters@clientec.com, diegocg@gmail.com, paul@clubi.ie,
       torvalds@osdl.org, linux-os@analogic.com, mrmacman_g4@mac.com,
       jmerkey@wolfmountaingroup.com, pmclean@cs.ubishops.ca,
       shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - V3 adds new restrictions
Message-Id: <20060127015811.03beb9e5.seanlkml@sympatico.ca>
In-Reply-To: <43D94D1D.8070300@perkel.com>
References: <43D114A8.4030900@wolfmountaingroup.com>
	<20060120111103.2ee5b531@dxpl.pdx.osdl.net>
	<43D13B2A.6020504@cs.ubishops.ca>
	<43D7C780.6080000@perkel.com>
	<43D7B20D.7040203@wolfmountaingroup.com>
	<43D7B5C4.5040601@wolfmountaingroup.com>
	<43D7D05D.7030101@perkel.com>
	<D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
	<Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
	<Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
	<Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>
	<Pine.LNX.4.64.0601261757320.3920@sheen.jakma.org>
	<20060126195323.d553a4b8.diegocg@gmail.com>
	<Pine.LNX.4.64.0601261255430.17225@turbotaz.ourhouse>
	<43D92175.6010804@perkel.com>
	<Pine.LNX.4.64.0601261344220.17514@turbotaz.ourhouse>
	<43D92B45.1030601@perkel.com>
	<Pine.LNX.4.64.0601261416090.17514@turbotaz.ourhouse>
	<43D94D1D.8070300@perkel.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2006 07:03:25.0328 (UTC) FILETIME=[C4682900:01C6230F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006 14:28:45 -0800
Marc Perkel <marc@perkel.com> wrote:

> Trying to look at this from a legal point of view. GPLv3 might actually 
> contradict GPLv2.
> 
> GPLv3 is more RESTRICTIVE than v2. With v2 you didn't have the new 
> anti-DRM and anti-patent restrictions. The original license says 
> somewhere that you can't change the license to be more restrictive.
> 
> None of us like patents and DRM but language that places new 
> restrictions on software might not be GPLv2 compatible. Stallman might 
> need to call his new license something else than GPL if he's going to 
> add language that adds restrictions.
> 
> I can see an argument where GPLv2 prohibits GPLv3.
> 

As the _owner_ of the code, you can set whatever license(s) you choose.  
You don't lose your copyright just because you've granted the rest of 
us the right to use your code under the terms of the GPL.

For instance, licensing your code to the world as GPL does not mean you 
can't also license it to another group of people under XYZ terms.  The 
XYZ license may be totally incompatible with the GPL and have many more 
restrictions (a prohibition against distribution for instance).  Anyone
who has agreed to the XYZ license with you, could also go grab a copy
of the GPL'd code, but would then have to abide by _all_ the GPL 
conditions.

Similarly, the owner of each piece of Linux code is free to make the 
code he released under GPLv2 available now under v3 without any
conflict or violation of the prohibition against additional restrictions.

Of course, older versions of the code would still be available 
under v2 as well; not even the owner can revoke that.

Sean
