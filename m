Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131378AbRCSHWB>; Mon, 19 Mar 2001 02:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRCSHVm>; Mon, 19 Mar 2001 02:21:42 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131365AbRCSHVi>;
	Mon, 19 Mar 2001 02:21:38 -0500
Message-ID: <20010318233955.D13058@bug.ucw.cz>
Date: Sun, 18 Mar 2001 23:39:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: "J. Michael Kolbe" <wicked@convergence.de>, linux-kernel@vger.kernel.org
Subject: Re: sysrq.txt
In-Reply-To: <20010316161919.A30690@midget.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010316161919.A30690@midget.convergence.de>; from J. Michael Kolbe on Fri, Mar 16, 2001 at 04:19:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've found that the Sysrq Keys on Apple Computers
> are 'Keypad+-F13-<command key>', maybe it would
> be a good idea to include that in Documentation/sysrq.txt.
> 
> The Patch:

This patch is reversed, but otherwise looks okay. Generate
non-reversed one and mail it to linus, possibly saying I agree.
								Pavel

> +++ sysrq.txt   Tue Dec 12 20:46:38 2000
> @@ -29,8 +29,6 @@
>             You send a BREAK, then within 5 seconds a command key. Sending
>             BREAK twice is interpreted as a normal BREAK.
>  
> -On Mac   - Press 'Keypad+-F13-<command key>'
> -
>  On other - If you know of the key combos for other architectures, please
>             let me know so I can add them to this section.
> 
> 
> regards,
> jmk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
