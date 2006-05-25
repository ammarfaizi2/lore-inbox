Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbWEYWPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWEYWPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWEYWPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:15:09 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:18560 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030470AbWEYWPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:15:07 -0400
Message-ID: <44762C6A.9090003@opensound.com>
Date: Thu, 25 May 2006 15:15:06 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.2) Gecko/20060404 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
References: <e55715+usls@eGroups.com>  <20060525212942.GS13513@lug-owl.de> <1148594527.31038.22.camel@mindpipe>
In-Reply-To: <1148594527.31038.22.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Thu, 2006-05-25 at 23:29 +0200, Jan-Benedict Glaw wrote:
>> If you work on drivers (as it seems), please just clean up the code
>> and post it to the kernel mailing list (or subsystem specific lists.)
>> Once it meets the standards, it'll just become a part of the tree,
>> releasing you from the burden to think about its local installation. 
> 
> I am fairly certain the drivers in question are closed source.
> 
>>From www.opensound.com:
> 
> "OSS is now free for home/personal use and doesn't have any restrictions
> other than refreshing the software every 4months."
> 
> Lee
> 
> 


Yes we are one and the same Open Sound System guys! :)

It doesn't matter if it's open sound or ALSA!. Lee, why don't you go down the
ALSA user mailing lists and count the number of 0-Compilation bug reports?

The same problems that affect ALSA (Fixed in CVS being the standard answer of 
why a sound driver isn't working) affects 4Front's OSS as well.

If you're telling people to compile ALSA downloaded from CVS,
you'd ensure that before they start filing bug reports:

1) people had their kernel source installed
2) kernel sources were "configured" for the running kernel
3) compilers/build utils and other libs would




best regards
Dev Mazumdar
-----------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA.
Tel: (310) 202 8530		URL: www.opensound.com
Fax: (310) 202 0496 		Email: info@opensound.com
-----------------------------------------------------------
