Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbSLLJDX>; Thu, 12 Dec 2002 04:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267445AbSLLJDX>; Thu, 12 Dec 2002 04:03:23 -0500
Received: from f52.sea1.hotmail.com ([207.68.163.52]:18695 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267444AbSLLJDW>;
	Thu, 12 Dec 2002 04:03:22 -0500
X-Originating-IP: [24.220.0.48]
From: "anon anon" <anon1978@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: cmipci gameport and gravis  gamepad pro
Date: Thu, 12 Dec 2002 09:08:46 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F52AkK5LqN33HFnwpGR00029bfb@hotmail.com>
X-OriginalArrivalTime: 12 Dec 2002 09:08:47.0151 (UTC) FILETIME=[1404C3F0:01C2A1BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an AudioExcel AV-511 (cmipci using the alsa drivers) and I'm having a 
heck of a time getting my Gravis Gamepad Pro (or the gameport of the cmipci 
sound card more to the point) to show up.  What kind of gameport do I have 
to compile support in for?  I tried standard plug and play gameport with the 
2.4 kernel and that says no such address etc. when I try to insmod ns558...  
I tried compiling it right in to the kernel but it didn't help.  I've also 
tried the 2.5 kernel but I still don't see anything that looks like a 
gameport in dmesg or /proc    /devices.  Is there any way to get my gameport 
on my cmipci sound card to show up under linux (both my Gravis Gamepad Pro's 
work good under windows98 so I know the port is good)?

My main goal is to have my gravis gamepad pro (gameport version of the 
controller) working in xmame, but just a few hints if someone could give 
them to me to get the card to even show up in the /proc filesystem would be 
helpfull.

(I've read joystick.txt and input.txt and the new input   homepage but I 
still have no luck.)

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

