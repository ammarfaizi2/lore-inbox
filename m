Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbUCZTbg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 14:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbUCZTbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 14:31:36 -0500
Received: from smtp.virgilio.it ([212.216.176.142]:8638 "EHLO
	vsmtp2alice.tin.it") by vger.kernel.org with ESMTP id S264127AbUCZTb0
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 26 Mar 2004 14:31:26 -0500
Message-ID: <40648545.2040004@futuretg.com>
Date: Fri, 26 Mar 2004 20:32:21 +0100
From: "Dr. Giovanni A. Orlando" <gorlando@futuretg.com>
Organization: Future Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Nikita Danilov <Nikita@namesys.com>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: Reiser4 needs more testers
References: <16484.24086.167505.94478@laputa.namesys.com> <406462C1.5020507@namesys.com>
In-Reply-To: <406462C1.5020507@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

Hi Hans,

    We will test the last snapshot.

Thanks,
Giovanni

> We have one NFS related bug remaining, and one mmap all of memory 
> related bug (and performance issue) that you can hit using iozone.  We 
> will fix both of these in next week's snapshot, they were both 
> multi-day bug fixes.  When they are fixed, unless users/distros find 
> bugs next week we will submit it for inclusion in the -mm and then the 
> official kernel.
>
> We hope it is now fairly stable for average users if you avoid those 
> two issues (we need to get rid of those dire warnings about its 
> stability...., we will remember that next snapshot....;-) )
>
> We need a lot more real user testers, because we have run out of 
> scripts that can crash it, and there are distros that would like to 
> ship it soon.  Please also complain to vitaly@namesys.com and 
> ramon@namesys.com about poor documentation, etc., ....
>
> The new reiser4 snapshot (against 2.6.5-rc2) is available at
>
> http://www.namesys.com/snapshots/2004.03.26/
>
>


-- 

-- 

--
Check FT Websites ... 
http://www.futuretg.com  - ftp://ftp.futuretg.com
http://www.FTLinuxCourse.com
                            /Certification
http://www.rpmparadaise.org
http://GNULinuxUtilities.com
http://www.YourPersonalOperatingSystem.com


--

       Europe:                          USA:
	Future Technologies             Future Technologies
	Viale Grigoletti, 20            1158 26th Street #592
	33170 - Pordenone (PN)          Santa Monica, CA 90403
	Italy.                          USA.



