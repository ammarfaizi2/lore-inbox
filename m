Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSKDCUh>; Sun, 3 Nov 2002 21:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264627AbSKDCUh>; Sun, 3 Nov 2002 21:20:37 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:14084 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S264624AbSKDCUg>; Sun, 3 Nov 2002 21:20:36 -0500
Date: Mon, 4 Nov 2002 13:27:07 +1100 (EST)
From: Tim Connors <tconnors@astro.swin.edu.au>
To: <linux-kernel@vger.kernel.org>
Subject: dell inspiron losing time - regression in 2.5
Message-ID: <Pine.LNX.4.33.0211041317090.16003-100000@hexane.ssi.swin.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this question has been asked here before, but I think some
electrons went missing from google when I checked.

I have a dell inpiron 4000 - and I just started using 2.5.

Under 2.4, the clock was rock-steady. But under 2.5, I am losing about 700
seconds a day - ntp can't even fix that. I have seen this behaviour before
with others - and they resort to turning off the battery monitor.

But I am wondering why this is only under 2.5 for me? I get a message at
bootup:
"Dell Inspiron machine detected. Enabling interrupts during APM calls."

I don't ever recall getting that in 2.4 - I have config set up with "Dell
laptop support" on and "Allow interrupts during APM BIOS calls" turned off
- just as I had it under 2.4.

So what has changed?

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

 * Progress (n.): The process through which Usenet has evolved from
   smart people in front of dumb terminals to dumb people in front of
   smart terminals.  -- obs@burnout.demon.co.uk (obscurity)

