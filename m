Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132054AbRD2VtD>; Sun, 29 Apr 2001 17:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136384AbRD2Vsx>; Sun, 29 Apr 2001 17:48:53 -0400
Received: from h24-76-184-93.vs.shawcable.net ([24.76.184.93]:1284 "EHLO
	candle.perlpimp.com") by vger.kernel.org with ESMTP
	id <S132054AbRD2Vsb>; Sun, 29 Apr 2001 17:48:31 -0400
Date: Sun, 29 Apr 2001 14:48:27 -0700
From: putter <spam@perlpimp.com>
To: linux-kernel@vger.kernel.org
Subject: reiserfs autofix?
Message-ID: <20010429144827.A751@vancouver.yi.org>
Reply-To: spam@perlpimp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Arbitrary-Number-Of-The-Day: 42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am kernel newbie, especially with logging filesystems.
Now I am using Mandrake 7.1 with 2.4.3 kernel and imon patch
and NVidia drivers compiled into the kernel.
Now, all my partitions are ReiserFS. I usually play quake once
or twice a day. Sometimes graphics subsystem freezes up, so it takes
keyboard input. Caps and Numlock are working fine, unless I try to kill
X with ctrlalt-backspace. So I reset my machine with hardware switch.

here is the interesting part... after I reset my machine like that,
some files start to appear corrupted. Segmentation faults etc. 
Isn't reiserfs suppose to be safe? NOW, THE REAL SPOOKY PART:
I reboot my machine with normal procedure, like shutdonw -r now,
and on other boot, corrupted files FIX themselves. Any insight?
I think it is rather unacceptable...
cheers,
	pavel
