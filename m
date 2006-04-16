Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWDPFNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWDPFNb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 01:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWDPFNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 01:13:31 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:30150 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751202AbWDPFNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 01:13:30 -0400
Date: Sun, 16 Apr 2006 01:13:18 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: HP Pavilion dv5320us, amd64 'turion' cpu
In-reply-to: <200604160446.18861.s0348365@sms.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Message-id: <200604160113.21644.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200604151457.12508.gene.heskett@verizon.net>
 <200604160446.18861.s0348365@sms.ed.ac.uk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 April 2006 23:46, Alistair John Strachan wrote:
>On Saturday 15 April 2006 19:57, Gene Heskett wrote:
>> Greetings;
>>
>> I've been dl'ing and burning cd's and dvd's at a furious rate for
>> several days now, looking for a 64 bit distribution that will
>> actually boot on this thing, apparently in vain.  i386 stuff works
>> fine. The kubuntu 'breezy' 5.10 locks up at the ACPI line regardless
>> of what kernel options you pass trying to disable it.
>
>If you really can't get it working, building an AMD64 cross compiler
> and an AMD64 kernel on a 32bit only distribution is surprisingly
> easy. It would allow you to debug any 64bit specific problems whilst
> allowing you to fall back on the comforts of a working kernel..

I finally got kubuntu dapper to boot and run quite nicely, but the added 
command line arguments to the boot added about 6 new arguments.  That 
allowed me to run gparted and although it didn't act like it did, it 
did shrink the ntfs partition down to about 27GB, and got rid of the 
other 2 partitions.  I've already made the backup dvd's of course.  XP 
is still happy in the reduced space.  But kubuntu subscribes to the Joe 
Sixpack theory a bit too firmly, not even supplying an accessable 
shell, just the run thingy, so I just burnt the FC5 x86-64 dvd iso, and 
k3b says the checksum is fubar but every disk it said that about has 
passed the disks own mediatests (so far).

So tomorrow, after church, and if the height of the yard doesn't call me 
first, I'm gonna try installing that puppy.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
