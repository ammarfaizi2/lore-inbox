Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbQKJVZG>; Fri, 10 Nov 2000 16:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131734AbQKJVY4>; Fri, 10 Nov 2000 16:24:56 -0500
Received: from [194.213.32.137] ([194.213.32.137]:5124 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131803AbQKJVYk>;
	Fri, 10 Nov 2000 16:24:40 -0500
Message-ID: <20001110154254.A33@bug.ucw.cz>
Date: Fri, 10 Nov 2000 15:42:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Antony Suter <antony@mira.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
In-Reply-To: <3A078C65.B3C146EC@mira.net> <E13t7ht-0007Kv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E13t7ht-0007Kv-00@the-village.bc.nu>; from Alan Cox on Tue, Nov 07, 2000 at 12:18:28PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This issue, and all related issues, need to be taken care of for all
> > speed
> > changing CPUs from Intel, AMD and Transmeta. Is the answer of "howto
> 
> Sensibly configured power saving/speed throttle systems do not change the
> frequency at all. The duty cycle is changed and this controls the cpu 
> performance but the tsc is constant

Do you have an example of notebook that does powersaving like that?

I have 2 examples of notebooks with changing TSC speed...

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
