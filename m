Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287793AbSBCVkt>; Sun, 3 Feb 2002 16:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287781AbSBCVkj>; Sun, 3 Feb 2002 16:40:39 -0500
Received: from ip68-4-123-226.oc.oc.cox.net ([68.4.123.226]:18932 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S287793AbSBCVk2>; Sun, 3 Feb 2002 16:40:28 -0500
Subject: Re: Machines misreporting Bogomips
To: aquamodem@ameritech.net
Date: Sun, 3 Feb 2002 13:40:40 -0800 (PST)
Cc: brand@jupiter.cs.uni-dortmund.de (Horst von Brand),
        gboyce@rakis.net (Greg Boyce), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "watermodem" at Feb 03, 2002 01:39:37 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020203214040.88493896F7@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

watermodem wrote:
> If they are Intel CPU's and the heatsink <-> CPU connection is poor
> (no heatsink compound, heatsink loose) or the fan is dead/dying or
> due to dust poor airflow this is reasonable.   Intel CPUs slow down
> when they get hot as as safety measure.

Note that this only applies to Pentium 4's. I believe Coppermine Pentium
III's will simply stop running (i.e., the computer freezes altogether
instead of slowing down) to prevent overheating. I'm not sure off the top
of my head what older Pentiums do, except that they certainly don't have
the slowdown trick that the Pentium 4 has.

Also, some BIOSes have an option called "CPU Speed at Boot" or something
like that, which has a Low and a High setting -- this serves the same
purpose as those old Turbo switches. (Note that I'm *not* talking about
the SpeedStep settings that newer laptops have in their BIOSes.)

-Barry K. Nathan <barryn@pobox.com>
