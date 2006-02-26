Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWBZWcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWBZWcY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWBZWcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:32:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:904 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751360AbWBZWcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:32:23 -0500
Date: Sun, 26 Feb 2006 23:32:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Luke-Jr <luke@dashjr.org>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works
 ;)
In-Reply-To: <200602261339.13821.luke@dashjr.org>
Message-ID: <Pine.LNX.4.61.0602262331330.12118@yvahk01.tjqt.qr>
References: <200602250042.51677.bero@arklinux.org> <200602261330.15709.luke@dashjr.org>
 <9a8748490602260529h3a2890bhce4112feefb7cb1f@mail.gmail.com>
 <200602261339.13821.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > I've just released dvdrtools 0.3.1
>> > > (http://www.arklinux.org/projects/dvdrtools/). It is a fork of cdrtools
>> > > that (as the name indicates) adds support for writing to DVD-R and
>> > > DVD-RW disks using purely Free Software,
>> >
>> > also DVD+R/RW/DL, I hope?
>>
>> And what about DVD-RAM drives? Any plans to support those?
>
>My [limited] understanding of DVD-RAM drives was that they are basically 
>removable block devices... you wouldn't need a recording program for that, 
>you'd use it like a floppy.
>
Same goes for DVD+RW. One may want to use it in conjunction with pktcdvd 
for aligning and command queueing/iosched reasons.


Jan Engelhardt
-- 
