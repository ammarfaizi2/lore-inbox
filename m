Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129992AbQKEUUg>; Sun, 5 Nov 2000 15:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129991AbQKEUU0>; Sun, 5 Nov 2000 15:20:26 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2820 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129853AbQKEUUK>;
	Sun, 5 Nov 2000 15:20:10 -0500
Message-ID: <20001105211413.A155@bug.ucw.cz>
Date: Sun, 5 Nov 2000 21:14:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Zach Brown <zab@zabbo.net>, Mo McKinlay <mmckinlay@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maestro3/Allegro: (was ESS device "1998")
In-Reply-To: <Pine.LNX.4.21.0011021158250.8426-100000@kyle.altai.org> <20001102104401.C16000@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001102104401.C16000@tetsuo.zabbo.net>; from Zach Brown on Thu, Nov 02, 2000 at 10:44:01AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> *nod*  Its the usual mc97 codec setup that leaves the hard work for the
> processor.  I'm sure one can play around with the dsp on it as well,
> but we don't have specs on the dsp's internals.

And if we had dsp specs, it would not help us. There's no freely
available v.34 stack, and v.31bis (14k4, I hope I have it right) is
free but needs port from multithreaded IRIX code.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
