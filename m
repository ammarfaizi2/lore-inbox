Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUJFBIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUJFBIr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUJFBIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:08:47 -0400
Received: from o3.xlccorp.com ([66.37.197.101]:24705 "HELO o1.xlccorp.com")
	by vger.kernel.org with SMTP id S266578AbUJFBIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:08:45 -0400
Message-ID: <416345C0.4050500@allvantage.com>
Date: Tue, 05 Oct 2004 21:09:20 -0400
From: Kenny Bentley <crash77a@allvantage.com>
Reply-To: crash77a@allvantage.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Converting kernel modules from 2.4 to 2.6/Suggested new driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Does anyone know if there is a detailed guide on how to convert kernel 
modules for 2.4 kernels to modules for 2.6 kernels?  I know very little 
about kernel module programming and haven't done any programming for a 
long time, although I do have a programming background, and I have 
drivers for HSF modems and Riptide sound cards that I want to convert 
from 2.4 modules to 2.6 modules, which shouldn't be too hard.  But I'll 
need a detailed guide to do it.

Or since I've never done any kernel programming, I have a better idea.  
I want to recommend the drivers for inclusion into the official kernel 
tree.  The drivers were released open-source by Linuxant or the 
manufacturer, I don't remember which one for sure.  But they're not 
being developed any further, and the Riptide sound card driver only 
supports OSS, and doesn't support ALSA.  Also, there are things in the 
drivers that need fixing that surely a lot of you can do much better 
than me.  I can help test the revised modules and I know how to put them 
in the kernel tree, so I can do those parts.  But many of you can do the 
programming better than I can.

I can't afford new hardware right now, and I had to search the net for 
hours and maybe even days just to find these drivers, and almost gave up 
hope of being able to use GNU/Linux as my primary OS.  I wouldn't want 
others to have to go through that or settle for mediocre drivers.  If 
there are any takers out there, just send me an E-mail and I'll send you 
the drivers so you can hack away.  But at the very least I'd like to 
know where I can find a detailed guild on how to convert kernel modules 
from 2.4 to 2.6.

Thanks.


