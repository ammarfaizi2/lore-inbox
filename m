Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312691AbSDBOoO>; Tue, 2 Apr 2002 09:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312694AbSDBOny>; Tue, 2 Apr 2002 09:43:54 -0500
Received: from [24.93.67.54] ([24.93.67.54]:31243 "EHLO mail7.mgfairfax.rr.com")
	by vger.kernel.org with ESMTP id <S312691AbSDBOnr>;
	Tue, 2 Apr 2002 09:43:47 -0500
Message-ID: <3CA99976.8060505@cox.rr.com>
Date: Tue, 02 Apr 2002 06:43:50 -0500
From: Louis Adamich <ladamich@cox.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020118
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.7 keyboard problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem getting my keyboard to work on 2.5.7.  2.5.5 
compiled and works correctly for me.  2.5.7 compiles with no errors as 
well as all modules compiling with no errors.  No matter what 
combination of config params I try I can't get the system to recognize 
keystrokes.  If I boot to level 3 I just see nothing when I type.  If I 
boot into X I can move the mouse around until I press a key and then the 
mouse freezes.  The machine is still running as I can telnet into it 
from another machine.  I also tried downloading and applying the dj 
patch.  Same symptoms.

Machine is an Althon XP 1800+, soyo dragon plus motherboard, ATI 128 
video card, 40 gig ide hard drive.

What info do I need to post to get some help debugging this thing?

Thanks,

Louis Adamich

