Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBUWy2>; Wed, 21 Feb 2001 17:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRBUWyS>; Wed, 21 Feb 2001 17:54:18 -0500
Received: from evl.evl.uic.edu ([131.193.48.80]:60683 "EHLO evl.uic.edu")
	by vger.kernel.org with ESMTP id <S129170AbRBUWyJ>;
	Wed, 21 Feb 2001 17:54:09 -0500
Date: Wed, 21 Feb 2001 16:54:01 -0600 (CST)
From: "Michael W. Bogucki" <mbogucki@evl.uic.edu>
To: linux-kernel@vger.kernel.org
Subject: hda: irq timeout's??
Message-ID: <Pine.SGI.3.95.1010221164326.75860B-100000@greenberg.evl.uic.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
	I know that this question has been asked in the past (according to
the archives), but I have not been able to find a solution to this problem
(in the archives.)
	First of all here's the system specs as well as OS.

Supermicro P6DNE (yeah I know..it's old...)
Bios Rev 1.8d (the latest one.)
64 Megs of Ram
8 gig Seagate U4 Model ST 38421A drive. 
Dual 166 Mhz (512k cache) procs

OS: Redhat ver 7.0 with kernel 2.2.16.
I've also tried 6.0, 6.1, 6.2 (with the stock kernels.)

Just recently I've been getting this error popping up on the console:

hda: irp timeout: Status=0xd0 {Busy}

**AS WELL AS**

hda: irp timeout: Status=0x58 {DriveReady SeekComplete DataRequest}

Now I will mention that I have replaced the harddrive in this system 4
times. Each time was because the drive started acting up (and these
messages were appearing.) 

The latest drive, which is less that 3 months old, will make all sorts of
clicking sounds...just like all the previous drives, and the system load
would go up beyond 2.0, just for a simple 'ls' command.

Has anyone been able to come up with a solution to this problem??

I have already tried using a POST probe as well as Microscope 2000.
They both state that nothing is wrong with the system.

Please email/CC back at mbogucki@evl.uic.edu.

Thank you for your time and help!!


--|\/| | |< E

The most exciting phrase to hear in science, the one that heralds new
discoveries, is not "Eureka!" (I found it!) but "That's funny ..."
                -- Isaac Asimov

