Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277395AbRJOL01>; Mon, 15 Oct 2001 07:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277401AbRJOL0S>; Mon, 15 Oct 2001 07:26:18 -0400
Received: from p25-max27.syd.ihug.com.au ([203.173.151.89]:12045 "EHLO
	bugger.jampot.org") by vger.kernel.org with ESMTP
	id <S277395AbRJOL0G>; Mon, 15 Oct 2001 07:26:06 -0400
Message-ID: <3BCAC80F.9050705@ihug.com.au>
Date: Mon, 15 Oct 2001 21:27:11 +1000
From: Cyrus <cyrusone@ihug.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
Newsgroups: alt.os.linux.slackware,alt.os.linux
To: linux-kernel@vger.kernel.org
Subject: Re: Large Storage Devices in Linux.....Kernel level support.....
In-Reply-To: <3BC93DCB.20400@linuxmail.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cyrus wrote:

 > hi all,
 >
 > i've got a setup of 2 hard drives (30GB & 40GB) with an Asus a7m266 mobo
 > with a VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06).
 >
 > 30GB= fujitsu, 40GB= IBM (both are 7200rpm
 >
 > i've got my cdrw on /dev/hdc, 30GB=/dev/hda, and 40GB=/dev/hdb...
 >
 > all works alright for a while, but when i keep my computer turned on for
 > a couple of days and then reboot. bios sometimes tells me that smart
 > array (or something) failed with my primary master (30GB) and i should
 > back-up soon.. next reboot it tells me that pri-master fails.. it's
 > doing this quite regularly and i don't know how to stop it. i'm running
 > kernel 2.4.12 vanilla.
 >
 > i'm sorry guys if this is the wrong place to ask but i could use some
 > hints in probably adding some options to the kernel at compile(config)
 > time to aid my ailing box.
 >
 > Cyrus Santos
 >
 > Registered Slackware Linux User # 220455
 > Sydney, Australia
 >
 > "...the best things in life are free...."
 >
 >
 >

hi all,

thanks for the feedback! i'll try all those recommendations now. by the
way i tried reiserfsck --check /dev/hda2, etc.... and it seems that
everything is ok... i suspect it's either the power supply or the
cooling... power supply because, i've got a 300W one but, almost all the
jumper power cables are used... i've got 2 chassis fans one for ducting
are out at the back below the power supply and one in front to drive the
air in.. i've separated my hard drives now they're not on top of each
other anymore... i'll try connecting the other hdisk to another power
cable and try if it does work.... i'll give apmd a go as well...

thanks guys!

btw, this is my real email address now Mike... cheers!


cyrus

-- 


Cyrus Santos

Registered Linux User # 220455
Sydney, Australia

"...the best things in life are free...."



