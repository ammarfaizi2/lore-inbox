Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130521AbRAIQoi>; Tue, 9 Jan 2001 11:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRAIQo2>; Tue, 9 Jan 2001 11:44:28 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129383AbRAIQoX>;
	Tue, 9 Jan 2001 11:44:23 -0500
Message-ID: <20010109004555.A7021@bug.ucw.cz>
Date: Tue, 9 Jan 2001 00:45:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthias Juchem <juchem@uni-mannheim.de>,
        "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug reporting script? (was: removal of redundant line in documentation)
In-Reply-To: <20010106075402.A3377@foozle.turbogeek.org> <Pine.LNX.4.30.0101061327090.4099-100000@gandalf.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0101061327090.4099-100000@gandalf.math.uni-mannheim.de>; from Matthias Juchem on Sat, Jan 06, 2001 at 01:33:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If ver_linux can take off one of those steps, why not include a script
> > which takes care of ALL the leg work? All of the files it asks the
> > reporter to include are o+r...
> 
> If have started a script that produces the following output. ( some fields
> need to be filled, but the structure will be like that). If you have additional
> ideas, please tell me. I'll include some more version numbers from system tools
> and, maybe, a routine that calls ksymoops.

This is horrible bugreport. Kill "keywords". Putting "modules" into
keywords i not going to help anyone. Having "4. Kernel version" and
minuses before actuall version is not helpfull, either.

								Pavel

> 4. Kernel version
> ----------------------------------------------
> Linux version 2.4.0 (root@gandalf) (gcc version 2.95.2 19991024 (release)) #6 Sat Jan 6 03:37:57 CET 2001

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
