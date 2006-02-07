Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWBGEK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWBGEK2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 23:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWBGEK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 23:10:28 -0500
Received: from beauty.rexursive.com ([218.214.6.102]:27334 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S964929AbWBGEK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 23:10:27 -0500
Message-ID: <20060207151024.ubk0xi74kckkwkgk@imp.rexursive.com>
Date: Tue, 07 Feb 2006 15:10:24 +1100
From: Bojan Smojver <bojan@rexursive.com>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Lee Revell <rlrevell@joe-job.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       suspend2-devel@lists.suspend2.net, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	<20060207030129.GA23860@mail> <1139282224.2041.48.camel@mindpipe>
	<200602071332.51676.nigel@suspend2.net>
In-Reply-To: <200602071332.51676.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nigel Cunningham <nigel@suspend2.net>:

> Of course, having said that, I don't know how
> many people would be more likely to use it if it was in mainline and they
> didn't have to patch their kernels, but I'd suspect it would be at least
> that number again.

Well, there are far more people that use what distrubutions provide 
than anything else. And distributions tend to like applying some 
patches to the vanilla kernel, but if at all possible, not to be too 
far away from mainline. Which is a good policy, of course, as it 
reduces the amount of work for them and makes them submit improvements 
upstream.

So, when distributors are able to get their hands on something that 
Just Works in the mainline, they will make sure things are nicely 
integrated, variety of configs are supported (like suspending to swap 
partitions, swap files or regular files), that the whole thing looks 
pretty and performs well. All of this can be done with Suspend2 today.

So, it isn't just about the basics any more (i.e. who can suspend and 
who cannot). Majority of users prefer things that work better, are 
faster and look prettier.

-- 
Bojan
