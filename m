Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbTIEUYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbTIEUWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:22:48 -0400
Received: from pimout6-ext.prodigy.net ([207.115.63.78]:22446 "EHLO
	pimout6-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265899AbTIEUWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:22:31 -0400
Message-ID: <3F58F08E.5060402@ameritech.net>
Date: Fri, 05 Sep 2003 15:22:38 -0500
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tonildg <tonildg@terra.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4  on to mpegs and DVB
References: <3F560DC6.2090709@ameritech.net>	<3F57D776.4050404@ameritech.net> <20030904173901.7ab1b4bb.akpm@osdl.org> <3F57EC78.80801@ameritech.net> <3F57F236.3000809@terra.es>
In-Reply-To: <3F57F236.3000809@terra.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tonildg wrote:
> 
>>>> The DVD looked and sounded great, but, it was using 98% of the CPU!  
>>>> 2.4 never used that much.
>>>
>>>
> 
> Couldn't it be caused by the Xfree configuration? I see you have a 
> Nvidia card. Have you compiled the Nvidia closed and fu*king module for 
> a 2.6.0-test4 kernel (if it is available ¿?¿?) ?
> 
> 
Twice posted.  The first time I replied to you in person.
The answer is NO!.  Default X11 rivafb stuff.
If it was NVIDIA special stuff the kernel would say "TAINTED" on the 
insmod.  It obviously dosen't!
NOT TAINTED!

The only tainting on that card is replacing the default heatsink with a 
huge one, silver heatsink paste and a processor fan.  It takes up 2 pci 
slots too but runs very cool. In fact, if you put your finger on the 
downside of the circuit board, you feel no heat.  Try that on your card. 
It is an absolutely rock solid video card with XFree drivers and 3+ 
years of use.

Again, NOT TAINTED, GOOD HARDWARE, Opensource software, GPL.  OK?


