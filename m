Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277334AbRJEJ1B>; Fri, 5 Oct 2001 05:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277337AbRJEJ0m>; Fri, 5 Oct 2001 05:26:42 -0400
Received: from mohawk.n-online.net ([195.30.220.100]:14089 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S277334AbRJEJ0e>; Fri, 5 Oct 2001 05:26:34 -0400
Date: Fri, 5 Oct 2001 11:17:22 +0200
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Odd keyboard related crashes.
X-Mailer: Thomas Foerster's registered AK-Mail 3.11 [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011005092640Z277334-760+20965@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm running 2.4.10, and the ps/2 keyboard came out of it's socket.

> On plugging back in, all worked fine, until 10 seconds later there was a
> crash. (the keyboard worked after being plugged in)
> No oops, just a reboot.
> Thinking this must just have been a wierd coincidence, after the system
> came back up, I tried it again, and again it crashed a few seconds afterwards.

> It doesn't seem to want to do this again though.

That's not a linux related problem, its a hardware problem.

I have the same thing happen with a Windows 2000 box.
Whenever i plug out the keyboard while the system is running and plugging it in
again, the system reboots.
It's the only system i can reproduce the problem, all other Linux boxes
(whatever kernel is running) run stable when playing with the keyboard.

Thomas

