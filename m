Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278879AbRJ1XQR>; Sun, 28 Oct 2001 18:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278877AbRJ1XQH>; Sun, 28 Oct 2001 18:16:07 -0500
Received: from f05s15.cac.psu.edu ([128.118.141.58]:18613 "EHLO
	f05n15.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S278868AbRJ1XQC>; Sun, 28 Oct 2001 18:16:02 -0500
Message-ID: <3BDC9246.4030107@stones.com>
Date: Sun, 28 Oct 2001 18:18:30 -0500
From: Justin Mierta <Crazed_Cowboy@stones.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.5) Gecko/20011011
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ECS k7s5a motherboard doesnt work
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, I'm not subscribed to the list, could any comments please 
be cc'd to crazed_cowboy@stones.com

Secondly, I thank you all very much for taking the time to help.

Here's the problem.  I just bought a 1.4 GHz AMD athlon and an ECS k7s5a 
motherboard.  I tried to install linux using this motherboard several 
dozen times, using several different distros (mandrake, redhat, and 
debian).  Not once did it install completely.  The problems ranged from 
the partition table being scrambled when it attempted to make the 
partitions, to failure to access harddisk, to failure to access the 
cdrom.  Cdrom failures were actually the most common reason for the 
failed install.  I tried the different distros, as well as an old 
version of mandrake which i know the install cd works (i used it on 
another computer).

Before the harddisk scrambling occurred the once or twice, I thought 
maybe my cdrom was no longer functioning (even though the same cdrom 
drive worked fine with linux with a different motherboard).  So I tried 
using a cdr drive, a dvd drive, and a regular 48x cdrom drive, and all 
of the distros had issues.

For this reason, i'm leaning towards believing that the ECS k7s5a's 
built-in ultradma controller is incompatable with linux.

Has anyone else experienced this, is this a known issue, and is any work 
being done to fix it?  or does anyone have any suggestions?

Thank you all very much for your time,
Justin

