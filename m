Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274675AbRJNHba>; Sun, 14 Oct 2001 03:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274666AbRJNHbV>; Sun, 14 Oct 2001 03:31:21 -0400
Received: from p250-tnt2.syd.ihug.com.au ([203.173.130.250]:44807 "EHLO
	bugger.jampot.org") by vger.kernel.org with ESMTP
	id <S274669AbRJNHbH>; Sun, 14 Oct 2001 03:31:07 -0400
Message-ID: <3BC93DCB.20400@linuxmail.org>
Date: Sun, 14 Oct 2001 17:24:59 +1000
From: Cyrus <cyrus@linuxmail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
Newsgroups: linux.dev.kernel,alt.os.linux,alt.os.linux.slackware
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Large Storage Devices in Linux.....Kernel level support.....
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i've got a setup of 2 hard drives (30GB & 40GB) with an Asus a7m266 mobo 
with a VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06).

30GB= fujitsu, 40GB= IBM (both are 7200rpm

i've got my cdrw on /dev/hdc, 30GB=/dev/hda, and 40GB=/dev/hdb...

all works alright for a while, but when i keep my computer turned on for 
a couple of days and then reboot. bios sometimes tells me that smart 
array (or something) failed with my primary master (30GB) and i should 
back-up soon.. next reboot it tells me that pri-master fails.. it's 
doing this quite regularly and i don't know how to stop it. i'm running 
kernel 2.4.12 vanilla.

i'm sorry guys if this is the wrong place to ask but i could use some 
hints in probably adding some options to the kernel at compile(config) 
time to aid my ailing box.

Cyrus Santos

Registered Slackware Linux User # 220455
Sydney, Australia

"...the best things in life are free...."




