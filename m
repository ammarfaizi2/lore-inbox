Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316959AbSG1PhB>; Sun, 28 Jul 2002 11:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316960AbSG1PhB>; Sun, 28 Jul 2002 11:37:01 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:3175 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S316959AbSG1PhA>; Sun, 28 Jul 2002 11:37:00 -0400
Message-ID: <3D441051.4060304@blue-labs.org>
Date: Sun, 28 Jul 2002 11:40:01 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020726
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Linux booting from USB HD / USB interface devices
References: <3D42E333.4010602@blue-labs.org> <20020727144922.E2730@one-eyed-alien.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 763; timestamp 2002-07-28 11:40:09, message serial number 168511
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.  I've started a rough draft of this project, 
http://blue-labs.org/ranger.php


Matthew Dharm wrote:

>>2) There are some vague comments about some devices requiring the 
>>ability to boot, are there some USB hard drives that are incapable of 
>>acting as a boot device?
>>    
>>
>
>Yes.  They are few, tho.  The USB-IF is currently working on a bootability
>standard to eliminate this problem.
>

Is there a list of these somewhere that point out components that I 
should avoid?

>
>THe stock kernel won't work.  There are patches floating around to make
>this work.  Basically, the kernel needs to pause for a couple of seconds
>before attempting to mount the root fs so that the plug-n-pray detection
>can work, identify the drive, and get going.
>

I'll go look for these patches, pointers are welcome of course.

David

-- 
I may have the information you need and I may choose only HTML.  It's up to
you. Disclaimer: I am not responsible for any email that you send me nor am
I bound to any obligation to deal with any received email in any given
fashion.  If you send me spam or a virus, I may in whole or part send you
50,000 return copies of it. I may also publically announce any and all
emails and post them to message boards, news sites, and even parody sites. 
I may also mark them up, cut and paste, print, and staple them to telephone
poles for the enjoyment of people without internet access.  This is not a
confidential medium and your assumption that your email can or will be
handled confidentially is akin to baring your backside, burying your head in
the ground, and thinking nobody can see you butt nekkid and in plain view
for miles away.  Don't be a cluebert, buy one from K-mart today.


