Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSG1IaP>; Sun, 28 Jul 2002 04:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSG1IaP>; Sun, 28 Jul 2002 04:30:15 -0400
Received: from mta02bw.bigpond.com ([139.134.6.34]:58314 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S315517AbSG1IaP>; Sun, 28 Jul 2002 04:30:15 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [cset] Add the EVIOCSABS ioctl for X people.
Date: Sun, 28 Jul 2002 18:29:02 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
References: <20020725083716.A20717@ucw.cz> <200207281732.53842.bhards@bigpond.net.au> <20020728100812.A12268@ucw.cz>
In-Reply-To: <20020728100812.A12268@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207281829.02627.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002 18:08, Vojtech Pavlik wrote:
> On Sun, Jul 28, 2002 at 05:32:53PM +1000, Brad Hards wrote:
> > "current" is a bad idea. I used curr_value.
> How about just "value" then?
If you want shorter, "curr" would be more understandable.
As you pointed out, all the structure elements are values.
Someone else might have a better name than "curr" though.

> I'm stil fighting with BK to use something else than my e-mail address
> in the changesets. So far I've always put the author of the patch into
> the BK comment at least, but still haven't found how to change the cset
> author.
It depends on an environment variable (see BK hacking howto in the
2.5 tree).
Like you, I am still strugling with BK. Hence the conventional
patches.

> If you find out, please tell me. Or anybody else.
>
> Thanks.
master.kernel.org:/home/torvalds/BK/tools apparently has some
scripts - I don't have access.

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
