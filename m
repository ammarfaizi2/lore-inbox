Return-Path: <linux-kernel-owner+w=401wt.eu-S932809AbWLNPjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932809AbWLNPjw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932811AbWLNPjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:39:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4741 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932809AbWLNPju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:39:50 -0500
Date: Thu, 14 Dec 2006 16:39:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James Morris <jmorris@namei.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214153949.GA3388@stusta.de>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <4580E37F.8000305@mbligh.org> <XMMS.LNX.4.64.0612140245230.6758@d.namei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XMMS.LNX.4.64.0612140245230.6758@d.namei>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 03:03:10AM -0500, James Morris wrote:
> On Wed, 13 Dec 2006, Martin J. Bligh wrote:
> 
> > The point of banning binary drivers would be to leverage hardware
> > companies into either releasing open source drivers, or the specs for
> > someone else to write them.
> 
> IMHO, it's up to the users to decide if they want to keep buying hardware 
> which leads to inferior support, less reliability, decreased security and 
> all of the other ills associated with binary drivers.  Let them also 
> choose distributions which enact the binary driver policies they agree 
> with.
>...


Unfortunately, we are living in an economic system with the strong 
tendency to create oligopolys.

Situations with only 1-3 manufacturers you can choose from are quite 
common (consider e.g. the 3D graphics market).

If you aren't a big company with big market power but a simple costumer 
who needs such hardware you have zero choice if all manufactorers only 
offer binary-only drivers at best.


And there's also the common misconception all costumers had enough 
information when buying something. If you are a normal Linux user and 
buy some hardware labelled "runs under Linux", it could turn out that's 
with a Windows driver running under ndiswrapper...


> - James

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

