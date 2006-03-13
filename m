Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWCMVKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWCMVKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWCMVKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:10:11 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:58293 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750877AbWCMVKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:10:08 -0500
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Avuton Olrich <avuton@gmail.com>, xfs-masters@oss.sgi.com,
       linux-xfs@oss.sgi.com, Dave Jones <davej@redhat.com>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, norsk5@xmission.com,
       dsp@llnl.gov, bluesmoke-devel@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, pete.chapman@exgate.tek.com,
       Olaf Hering <olh@suse.de>, paulus@samba.org, anton@samba.org,
       linuxppc64-dev@ozlabs.org, Tom Seeley <redhat@tomseeley.co.uk>,
       Jiri Slaby <jirislaby@gmail.com>, laredo@gnu.org,
       v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
Subject: Re: 2.6.16-rc6: known regressions
In-reply-to: <20060313121219.GB13652@suse.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060313200544.GG13973@stusta.de>
Message-Id: <E1FIuFC-0004kk-00@decibel.fi.muni.cz>
Date: Mon, 13 Mar 2006 22:06:22 +0100
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@informatics.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>On Mon, Mar 13, 2006 at 09:05:44PM +0100, Adrian Bunk wrote:
>> Subject    : Stradis driver udev brekage
>> References : http://bugzilla.kernel.org/show_bug.cgi?id=6170
>>              https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
>>              http://lkml.org/lkml/2006/2/18/204
>> Submitter  : Tom Seeley <redhat@tomseeley.co.uk>
>>              Dave Jones <davej@redhat.com>
>> Handled-By : Jiri Slaby <jirislaby@gmail.com>
>> Status     : unknown
>
>Jiri, why did you create a kernel.org bugzilla bug with almost no
>information in it?
>
>Anyway, this is the first I've heard of this, more information is
>needed to help track it down.  How about the contents of /sys/class/dvb/ ?
Hello,

sorry for that, I expected Tom to help us track this down -- he has this
problem, but he haven't replied yet. Nobody else is complaining, would we defer
or close it for now?

best regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
