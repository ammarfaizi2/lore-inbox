Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286413AbSBCHhW>; Sun, 3 Feb 2002 02:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286447AbSBCHhM>; Sun, 3 Feb 2002 02:37:12 -0500
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:21743 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S286413AbSBCHhD>; Sun, 3 Feb 2002 02:37:03 -0500
Message-ID: <3C5CE939.6030609@ameritech.net>
Date: Sun, 03 Feb 2002 01:39:37 -0600
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
CC: Greg Boyce <gboyce@rakis.net>, linux-kernel@vger.kernel.org
Subject: Re: Machines misreporting Bogomips
In-Reply-To: <200202010959.g119xXH3008047@tigger.cs.uni-dortmund.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

> Greg Boyce <gboyce@rakis.net> said:
> 
> [...]
> 
> 
>>Every once in a while we come across single machines which are running a
>>lot slower than they should be, and are misreporting their speed in
>>bogomips under /proc/cpuinfo.  Reinstalling the OS and changing versions
>>of the kernel don't appear to affect the machines themselves at all.
>>
> 
> Just misrepresented bogomips or is the machine really slower? Perhaps the
> CPU is being underclocked?
> 

If they are Intel CPU's and the heatsink <-> CPU connection is poor
(no heatsink compound, heatsink loose) or the fan is dead/dying or
due to dust poor airflow this is reasonable.   Intel CPUs slow down
when they get hot as as safety measure.

Clean the machine,  remove the heatsink/fan. Replace fan if needed.
(they are cheap so replace).  Clean or replace heatsink.  Apply a
good heatsink compound such as ArticSilver. [just a small dab]
Make sure you have proper contact and preasure.   Re-run the speed test.

If the video card, case or motherboard have fans check them too.
Note that some of these heatsinks are epoxied on with a conductive
epoxy so it is unlikely that you could safely remove those. Replacing
the fans is ok though.  If you are unsure of the proceses go to
one of the hardware or overclocking web pages.






