Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSLaMcx>; Tue, 31 Dec 2002 07:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSLaMcx>; Tue, 31 Dec 2002 07:32:53 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:3332 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262418AbSLaMcv>; Tue, 31 Dec 2002 07:32:51 -0500
Date: Tue, 31 Dec 2002 04:41:13 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Hell.Surfers@cwctv.net
cc: linux-kernel@vger.kernel.org, rms@gnu.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <085e72754031fc2DTVMAIL12@smtp.cwctv.net>
Message-ID: <Pine.LNX.4.10.10212310412290.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Dec 2002 Hell.Surfers@cwctv.net wrote:

> Why does the community continue to make pacts with a company that
> steals from its rivals, makes pacts with M$, and refuses to clearly GPL
> and open source its work on drivers, there is a clear difference between
> their use of GPL files, and what the GPL says they can do. You cannot
> expect embedded kernel developers to GPL, if you excuse Nvidia, its a
> vain hope to grab M$ users, but in the long run it destroys the
> community.
> 
> Dean. Three ways to kill yourself, and ive been drove in one...

Well let's see:

You have no money to hire lawyers.
You whine about an issue, that people with lawyers will roast you alive.

Are you a customer of Nvidia?
If you are not, you have no legal ground to invoke GPL PERIOD!
If you are a customer, check to see that they have a GPL/GNU wrapper which
is open source and attachs a clean LGPL library object, iirc.

Since, there is still a legal and valid LGPL regardless of what FSF has to
say, there are revisions of GPL which permit various usages.  Now there
are people like yourself who, again have no money, have no lawyers, have
a whine, and whimpers over issues that stretch beyond the general scope.

Recall the kernel is capable of rejecting non-gpl binary modules; yet it
does not!  Regardless of the original intent or scope of the "tainting
process", it created more grey than clarity.

Now until the kernel forcable rejects loading binary closed source
modules, it defaults to quietly approved of the concept regardless what
you think, feel, or care.

Now what is not clear?

If the kernel forces vendors to choose between closed source support or
loose the competive edge in their market space, enjoy hunting for the old
dusty video cards from the past.  You just limited the scope of hardware
which will run on Linux with any usability.

Now given the kernel is now so well mixed between people in the past,
current, and dead developers (sigh Leonard Z :-(( ), how are you going to
hurd all togather to agree on a single point?

So you submitted a patch, whippty flip ... neither you or I control the
license of the kernel.  If Linus does not like the content of a patch or a
file generated, well it is toast.  Also where does it state a patch is
defined as "GPL patch"?

Think a little harder first, cause I and many others will be on the side
of slapping down your arguements about preventing binary modules from
being loaded.  Key point! "LOADED" not "LINKED".  For the meatballs who
think that dumping /proc/kcore is an effective way of generating a newly
linked file, remember you created the file, not the owners of the module.

Prove you can boot a cat /proc/kcore > vmlinux and you have now linked a
closed source object with an open source kernel.  Using your logic from
above, you are now the offending person to GPL.  You committed the act of
linking the two permanetly.

Time for bed, ranting is over ...

Cheers,

Andre Hedrick
LAD Storage Consulting Group

