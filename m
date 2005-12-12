Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVLLLXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVLLLXj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 06:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVLLLXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 06:23:39 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:39555 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751235AbVLLLXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 06:23:39 -0500
Message-ID: <439D5E96.3030607@aitel.hist.no>
Date: Mon, 12 Dec 2005 12:27:18 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke-Jr <luke-jr@utopios.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512061850.20169.luke-jr@utopios.org> <4397EB7A.7030404@aitel.hist.no> <200512081130.05095.luke-jr@utopios.org>
In-Reply-To: <200512081130.05095.luke-jr@utopios.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke-Jr wrote:

>On Thursday 08 December 2005 08:14, you wrote:
>  
>
>>Luke-Jr wrote:
>>    
>>
>>>The ATi Radeon 9200 works fine...
>>>      
>>>
>>Lucky you.  Mine doesn't.  Using 3D on it makes the machine unstable,
>>and the performance is apalling too.
>>    
>>
>
>Hm, well I don't have DRI enabled on my primary desktop... just on a second 
>one dedicated to gaming. Not sure if that makes any difference...
>
>  
>
>>So I'm looking for something else - a radeon 7000 is cheap .  . .
>>    
>>
>
>That'll outperform a 9200? ;)
>  
>
Actually yes, because something is clearly wrong.
The pci 9200 SE can run tuxracer at 640x480 - not smooth
but playable until it locks the machine after a few minutes.

The AGP matrox G550 is better, it runs 1280x1024 tuxracer
with a unknown but noticeable higher framerate.  According to
people I talked to before, the 9200SE is supposed to outperform
this, even with a pci bus.  But it is not even close and I don't
bother running 3D on it any more due to the hanging.

>  
>
>>And don't say that a crash during a 3D game isn't important -
>>    
>>
>
>A system crash? Worst I've ever seen was a X crash, back before I got my X 
>configs good. If you mean a game crash, I wouldn't know... half the time it'd 
>probably be my fault. ;)
>  
>
I don't mind a game crash - I can always find another game.  But it will
at least screw up that card so bad that I need a reboot to get
a working xserver running on that display.  Typically, the
crash ends with a 99% cpu loop in the kernel, a blocked display,
and perhaps the other xserver gets in trouble too.

>  
>
>>it is a two-user machine and the other user is not amused when this happens.
>>    
>>
>
>Maybe he would be if it showed a BSOD? :p
>  
>
Nope.  A windows crash isn't any "better", and they are used to
the linux-level of stability anyway.

Helge Hafting
