Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261808AbTCaTJB>; Mon, 31 Mar 2003 14:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261812AbTCaTJB>; Mon, 31 Mar 2003 14:09:01 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:15450 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S261808AbTCaTI7>; Mon, 31 Mar 2003 14:08:59 -0500
Message-ID: <3E88942F.2090407@myrealbox.com>
Date: Mon, 31 Mar 2003 14:17:03 -0500
From: Nicholas Wourms <nwourms@myrealbox.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [announce] kmsgdump for 2.5.65/66
References: <20030319141048.GA19361@suse.de>	<20030320112559.A12732@namesys.com>	<20030320132409.GA19042@suse.de>	<20030320165941.0d19d09d.akpm@digeo.com>	<20030320231335.GB4638@suse.de>	<20030320153427.6265e864.rddunlap@osdl.org>	<3E7CBB27.8090506@myrealbox.com> <20030331105341.72ec6b8a.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> 
> so.....
> 
> kmsgdump for Linux 2.5.65/2.5.66
> 2003-03-31
> version 0.4.5

Thanks for porting this to 2.5.66!

[SNIP]


> 2.  The kmsgdump text-mode interface doesn't work with a USB-only keyboard
> setup.  I had to add a PS/2 keyboard to my test system to use it.

Hey, it's better then the alternative ;-).  I, too, use a 
usb keyboard.  Perhaps some of the kdb usb code could be 
ripped off?

Cheers,
Nicholas

