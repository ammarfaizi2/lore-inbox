Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132133AbRBKKmn>; Sun, 11 Feb 2001 05:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132152AbRBKKmh>; Sun, 11 Feb 2001 05:42:37 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132133AbRBKKmZ>;
	Sun, 11 Feb 2001 05:42:25 -0500
Message-ID: <20010211005554.J7877@bug.ucw.cz>
Date: Sun, 11 Feb 2001 00:55:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Gilbert <gilbertd@treblig.org>, linux-kernel@vger.kernel.org
Subject: Re: Losing a keystroke or two? -- no problem, I have seen even duplicating keystrokes
In-Reply-To: <Pine.LNX.4.10.10102052059230.1103-100000@tardis.home.dave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.10.10102052059230.1103-100000@tardis.home.dave>; from Dave Gilbert on Mon, Feb 05, 2001 at 09:00:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   I maybe going mad (or it may be too late) - but I've been starting X,
> quitting and restarting - and there are a couple of times over the last
> day where I could have sworn that I pressed return on the startx and had
> to hit return again.
> 
> This is 2.4.1-ac2 with XFree 4.0.2 on Alpha.
> 
> OK - it might be just going mad; but I'm fairly sure its loosing a key
> there.....

That's nothing, I've had iMac usb keyboard typing "cdcd " instead of
"cd " when I typed too fast.

That really drived me mad. I found out that keyboard just can't cope
with me pressing ("c down" "d down" "space down" "c up") -- all normal
keyboards can handle that normally.

Check that you are not pressing something like I did -- it happens
pretty often when you touch-type.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
