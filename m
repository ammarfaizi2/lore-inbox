Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317388AbSGXQMt>; Wed, 24 Jul 2002 12:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSGXQMs>; Wed, 24 Jul 2002 12:12:48 -0400
Received: from server1.mvpsoft.com ([64.105.236.213]:35251 "HELO
	server1.mvpsoft.com") by vger.kernel.org with SMTP
	id <S317388AbSGXQMr>; Wed, 24 Jul 2002 12:12:47 -0400
Message-ID: <3D3ED215.3080900@mvpsoft.com>
Date: Wed, 24 Jul 2002 12:13:09 -0400
From: Chris Snyder <csnyder@mvpsoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020713
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problems with Mylex DAC960P RAID controller
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I emailed this list a couple of weeks ago with problems I was having 
with an Intergraph SMP server.  I ended up giving up with that box, and 
built a new server with a 2 ghz Athlon, 1GB RAM, etc.  I kept the RAID 
array, however, as it was the most expensive part of the old server, and 
is still usable.  The array is three 9 gig IBM SCSI-2UW disks on a Mylex 
DAC960P controller.  The controller was recently updated to the latest 
firmware (2.73)

I'm having problems, however, trying to get the card to work.  Whenever 
I try to insert the module for the card into my kernel, the system 
completely hangs.  I tried this both with the kernel version that comes 
with my distro CD, and 2.4.18, compiling it directly into the kernel 
with the latter.  In both cases, it hanged when trying to load the 
driver.  It will display the version information, but that's it.

Any idea what's going on?  I just convinced the boss to spend some money 
for new equipment, and I'd rather not have to spend more at the moment. 
  TIA.

