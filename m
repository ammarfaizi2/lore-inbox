Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVBUS0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVBUS0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 13:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVBUS0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 13:26:23 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:45813 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S262067AbVBUS0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 13:26:06 -0500
Date: Mon, 21 Feb 2005 13:25:54 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: OT: Why is usb data many times the cpu hog that firewire is?
In-reply-to: <200502211858.34301.oliver@neukum.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200502211325.55013.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200502211216.35194.gene.heskett@verizon.net>
 <200502211858.34301.oliver@neukum.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 February 2005 12:58, Oliver Neukum wrote:
>Am Montag, 21. Februar 2005 18:16 schrieb Gene Heskett:
>> Greetings;
>>
>> Motherboard is a biostar with nforce2 chipset, 2800xp cpu, gig of
>> ram.
>>
>> I've recently made the observation that while I can view 30fps
>> video from my firewire equipt movie camera with a minimal cpu hit
>> of 2-3%, but viewing the video from a webcam on a usb 1.1 circuit
>> takes 30-40% of the cpu, at half the frame rate.
>>
>> Do I have something fubar in the usb?  Or is this just the nature
>> of the beast?
>
>A video stream over usb1.1 must be compressed due to bandwidth
> available. Decompression needs cpu.
>
Thats what I was afraid of, which makes using it for a motion detected 
burgular alarm source considerably less than practical since the 
machine must be able to do other things too.  Darn.  And its usb1.1 
even when plugged into a 2.0 capable port.

One could probably use the FIR output of an EagleEye (X10 stuff) to 
start & stop a capture, but the lag inherent in that is less than 
'optimum' IMO.

Thank you Oliver.

> Regards
>  Oliver

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
