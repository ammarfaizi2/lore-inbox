Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUH0WVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUH0WVM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 18:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUH0WTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 18:19:12 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:45326 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264726AbUH0WOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 18:14:36 -0400
Message-Id: <6.1.2.0.2.20040827233253.01c36210@inet.uni2.dk>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.2.0
Date: Sat, 28 Aug 2004 00:08:05 +0200
To: Jesper Juhl <juhl-lkml@dif.dk>
From: Kenneth Lavrsen <kenneth@lavrsen.dk>
Subject: Re: Summarizing the PWC driver questions/answers
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.61.0408272259450.2771@dragon.hygekrogen.localho
 st>
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
 <Pine.LNX.4.61.0408272259450.2771@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  I have boxes where I can't run the latest version
>of AIX any more since the hardware is no longer supported, but you don't
>see me ripping IBM's head off for that reason.

Ehhh????? No comment.

>As I understand it the hook should never have been added in the first
>place. Doesn't matter if it has been there for a day, a week, a year or 10
>years - it should never have been added and once it was discovered it was
>removed - I have no trouble with that bit, especially since the pieces
>are still out there and you are free to just patch your personal kernel in
>any way you please to get the result you desire, or you can just stick
>with an older kernel until a suitable alternative shows up.

Why not let the current driver be and then work on the alternative?
Why is it so important that it is removed now?
Why does it have to be done in a way that create a problem for the common 
users?
Linus indicated that since Nemosoft had asked for his driver to be removed 
noone else could take the sources as they are and add them again. So any 
altertive would be a start from scratch? Or did I misunderstand this?
That can take years. So I cannot update my kernel for years?
How many normal users knows even how to compile their own kernel?
You guys on this list talk as if anyone knows how to write a kernel module. 
I think most of you have lost contact with the real users.

>And why is it you expect open source developers to assist in supporting
>binary only drivers?

I am just asking for you guys to not DESTROY what is already there without 
an alternative.

>Binary only drivers undermine open source. If you want to depend on closed
>drivers go ahead, but if that support disappears then take it up with the
>company unwilling to provide open drivers or open specs so people can
>write their own open drivers.

Treating the normal users using Linux this badly undermines open source 
1000 times more I can assure you.
Linux is getting a reputation of being an operating system that you cannot 
trust being fully available in the future.
I am hearing those arguments in my own company. Stability and making sure 
that investments in information technilogy will not be obsolete at least 
some years is vital.

>You purchased a piece of hardware that depended on a closed source driver,
>no open source developer has any resonable commitment to support that.

It is sad that you need legal counselling before you buy a USB camera.
Besides. There are no real altertives. I have tried 4-5 other cameras using 
for example the OV511 driver. They all failed. They were either not light 
sensitive enough for surveillance at night or the firmware/driver was so 
unstable that the cameras froze and had to be disconnected to work again. 
Only the pwc driven cameras are stable and good enough.
Otherwise you have to use expensive real video cameras and they cost many 
times more for the same quality image.
So I did not really have much choice. And this is still the case as far as 
I know.


>If you want to be constructive instead of just bitch and moan, then go
>talk to Philips and get them to release code or specs so we can get proper
>open source drivers - your real beef is with them, not with open source
>developers.

Many have. And I will again. But if Philips will not let their competitors 
know about some brillient compression algoritm we cannot blame them for 
protecting their investment in the development. In the real world not 
everything can be open source. At least not when new technology needs to be 
kept secret to prevent copycat companies from lawless countries to harvest 
the fruits of expensive investments.
It is our own jobs that are in danger. Remember that.
But I think it is about time Philips releases the code or at least algoritm 
now. The copycats must have reverse engineered that little piece of code 5 
times now.
I have tried also but it is just too difficult for me to follow the binary 
stuff.

>PS. I'm wondering why you asked Linus a whole host of questions yet did
>not even CC the man on your email.

On most mailing lists people get angry if they receive the same mail both 
from the list and directly. It seems to be different on this list. I am 
starting to figure out the tradition here.

Kenneth

PS: Thanks to the many that writes support mails directly to me. I am 
really happy to receive them. And post them in public too. Linus is not God 
and he is not always right. He and his kernel developers need to learn that 
there are actual users out there.


-- 
Kenneth Lavrsen,
Glostrup, Denmark
kenneth@lavrsen.dk
Home Page - http://www.lavrsen.dk 


