Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268223AbTBSBVr>; Tue, 18 Feb 2003 20:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268226AbTBSBVr>; Tue, 18 Feb 2003 20:21:47 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:61157 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP
	id <S268223AbTBSBVp>; Tue, 18 Feb 2003 20:21:45 -0500
Message-ID: <3E52DE8B.6040002@verizon.net>
Date: Tue, 18 Feb 2003 20:31:55 -0500
From: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: a really annoying feature of the config menu structure
References: <Pine.LNX.4.44.0302181604310.23007-100000@dell>	 <3E52B4CE.7040009@verizon.net> <1045619804.25795.14.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1045619804.25795.14.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [64.223.82.122] at Tue, 18 Feb 2003 19:31:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Tue, 2003-02-18 at 22:33, Stephen Wille Padnos wrote:
>  
>
>>[snip]
>>
>>    
>>
>>> as i see it, this can only get worse.  the current
>>>erratic and disorganized structure of the config menus
>>>is proof of that.
>>>
>>> comments?
>>>
>>>      
>>>
>>I think the problem with the "Multimedia" menu is that it's misnamed.  
>>It should actually be the "tuners" menu - it's there for audio, digital 
>>video, and video tuners.  The same could be said of the networking menu, 
>>and presumably others.
>>    
>>
>
>It covers lots of tunerless mpeg and mjpeg stuff. Eg the DVB stuff will
>eventually include the Margi PCMCIA DVD player and we already have other
>pure mpeg or pure webcam stuff in there
>

It seems that the mjpeg stuff will be in the wrong place when it starts 
being used by non-DVB modules.  I see the two (DVB and mjpeg) as 
distinct entities - like ethernet drivers and ipv4.  (DVB drivers should 
let you change channels and whatnot, mjpeg drivers should allow you to 
decode data streams from any available source.)

- Steve


