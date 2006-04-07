Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWDGGPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWDGGPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 02:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWDGGPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 02:15:05 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:50914 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S932293AbWDGGPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 02:15:03 -0400
Date: Fri, 07 Apr 2006 02:15:01 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [RFC: 2.6 patch] the overdue removal of
 RAW1394_REQ_ISO_{LISTEN,SEND}
In-reply-to: <200604070852.36924.vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200604070215.01791.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060406224706.GD7118@stusta.de>
 <200604062035.23880.gene.heskett@verizon.net>
 <200604070852.36924.vda@ilport.com.ua>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 01:52, Denis Vlasenko wrote:
>On Friday 07 April 2006 03:35, Gene Heskett wrote:
>> >This patch contains the overdue removal of the RAW1394_REQ_ISO_SEND
>> > and RAW1394_REQ_ISO_LISTEN request types plus all support code for
>> > them.
>> >
>> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
>>
>> NAK if my vote is worth $.02.  ieee1394 has been broken since
>> 2.6.13-rc1, and apparently no one cares.  I have a firewire movie
>> camera I haven't been able to use since then.  A Sony DVR-TVR460.
>
>You may help by narrowing it down to exact 2.6.x[-rcY] where it broke.

Apparently it broke with the commits that came in between 2.6.12 and 
2.6.13-rc1.

I can't get any closer than that, and someone else has also commented 
that this is when it died.  I hadn't needed it between may-june of last 
year and now, so I hadn't dug out the camera and tested it until the 
missus asked if I could make dvd's of some of her vhs stuff since the 
vhs player is on its last legs, not from head wear, but something on 
the board requires a healthy slap in the chops to make it work after 
its been off for a few weeks.

I was going to use the camera as a transcoder between the sloppily timed 
ntsc, and the firewire port.  Now it locks kino up tighter than a drum 
the minute you select the capture screen.  You have to click on the 
close button, and wait for the x server to ask you if you want to stop 
the process since it isn't responding.  But that once done, seems to 
clean up the mess nicely.

>--
>vda

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
