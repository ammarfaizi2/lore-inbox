Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSHOAar>; Wed, 14 Aug 2002 20:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSHOAar>; Wed, 14 Aug 2002 20:30:47 -0400
Received: from email.careercast.com ([216.39.101.233]:54759 "HELO
	email.careercast.com") by vger.kernel.org with SMTP
	id <S316187AbSHOAaq>; Wed, 14 Aug 2002 20:30:46 -0400
Subject: RedHat 7.3 kernel fix
From: Matt Simonsen <matt_lists@careercast.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 14 Aug 2002 17:34:13 -0700
Message-Id: <1029371653.26279.39.camel@mattswork>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am hoping there are some out there using RedHat 7.3 on a DL380. We are
trying to do so, I have got 3 kernel panics in a week.

The setup is basically completely stock, I did do the 2.4.18-5 kernel
upgrade, basically running the RPM, then changing the lilo.conf to point
to the new kernel files and running /sbin/lilo. 

I did not install 2.4.18-4 which mentions the SMP kernel panic
explicitly - should I have installed this before the -5 kernel? From the
errata it seems the -4 is superseded by -5 implying I didn't need it.
Also, should I be using the drivers on Compaq's site? My previous setup
was/is RedHat 6.2 with a 2.4.17 kernel and that worked beautifully.

At this point the machine known good hardware, although I moved some RAM
into it along with the OS move and I'm just not sure where to go. It's
in a data center so getting the on screen dump isn't easy, while there
is nothing in the logs.

I'm sorry I haven't provided much info - it's all I have, though.
Perhaps I'm just looking for somebody who has used the same OS and
hardware combo to let me know for sure it works.

Thanks
Matt


