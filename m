Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264848AbSLGW1S>; Sat, 7 Dec 2002 17:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSLGW1R>; Sat, 7 Dec 2002 17:27:17 -0500
Received: from khms.westfalen.de ([62.153.201.243]:2201 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S264848AbSLGW1O>; Sat, 7 Dec 2002 17:27:14 -0500
Date: 07 Dec 2002 22:34:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8bPzdF91w-B@khms.westfalen.de>
In-Reply-To: <aso4kq$2ka$1@penguin.transmeta.com>
Subject: Re: is KERNEL developement finished, yet ???
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <aso4kq$2ka$1@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 05.12.02 in <aso4kq$2ka$1@penguin.transmeta.com>:

> In article <000901c29c5d$6d194760$2e833841@joe>,
> Joseph D. Wagner <wagnerjd@prodigy.net> wrote:
> >
> >Unix (and Linux) developers are far too concerned with clinging to the
> >30-year-old outdated POSIX standard, which creates numerous problems when
> >trying to advance new features.
>
> No.
>
> Only stupid people think they should throw away old proven concepts.
> What happens quite often in academia in particular is that you find a
> problem you want to fix, and you re-design the whole system around your
> fix.

Well, yes and no.

Yes, it's usually a bad idea to do that and expect to get a production- 
level kernel out of it.

But on the other hand, there's a lot that *could* be done with OS kernels  
that has never been tried (even though I certainly couldn't give a list).  
Until someone implements one of those ideas, and experiments with the  
results for a while, it's impossible to know what it would be worth in  
practice. (I certainly wouldn't want to trust a theoretical evaluation!)

Then, *if* it looks good in an experimental OS, people still need to  
figure out how to make use of it in a more traditional kernel. Sometimes  
that's where it breaks. Sometimes not.

If you just remember that academic OSes are *research*, not production  
material, then they are fine. Unfortunately, too many people (including  
many academics) forget that.

There's a reason we have both science and engineering, and they're not the  
same discipline.

MfG Kai
