Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279749AbRJYKRR>; Thu, 25 Oct 2001 06:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279747AbRJYKRI>; Thu, 25 Oct 2001 06:17:08 -0400
Received: from p32-max14.syd.ihug.com.au ([203.173.154.32]:30217 "EHLO
	bugger.jampot.org") by vger.kernel.org with ESMTP
	id <S279749AbRJYKQw>; Thu, 25 Oct 2001 06:16:52 -0400
Message-ID: <3BD7E51C.6030304@ihug.com.au>
Date: Thu, 25 Oct 2001 20:10:36 +1000
From: Cyrus <cyjamten@ihug.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011020
X-Accept-Language: en-us
MIME-Version: 1.0
Newsgroups: alt.os.linux.slackware,alt.os.linux,linux.dev.kernel
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: dmesg.... hdc: CHECK for good STATUS?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

just upgraded to kernel 2.4.13... well, in any case i still get this 
message on 2.4.12 and ac patches after 2.4.12 as well....

just a question i don't know what it means... hdc is a dvd-rom drive i 
used to use scsi emulation on it and it seems on kernel 2.4.13... it 
crashes my box... couldn't log onto it from another machine to shutdown 
properly... by i mean crashes, X just freezes.. i'm tryind to omit the 
scsi-emu now and try it as a normal ide device and tune it with 
hdparm... still the same message...

Another thing, for dvd playing in linux. is it better to use hdparm or 
scsi-emu... i'm pretty new with dvd's in linux so i'm asking for a few 
pointers as well as kernel configuration options and such...

cheers all!

thanks!


cyrus

-- 


Cyrus Santos

Registered Linux User # 220455
Sydney, Australia

"...the best things in life are free...."


