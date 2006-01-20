Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWATMXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWATMXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWATMXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:23:04 -0500
Received: from mexforward.lss.emc.com ([168.159.213.200]:37522 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750883AbWATMXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:23:02 -0500
Message-ID: <43D0D5AC.2010604@emc.com>
Date: Fri, 20 Jan 2006 07:21:00 -0500
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       linux-m68k@vger.kernel.org, geert@linux-m68k.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: License oddity in some m68k files
References: <20060119180947.GA25001@kroah.com> <Pine.LNX.4.61.0601192014010.30994@scrub.home> <20060119220431.GA4739@kroah.com> <1137708896.8471.71.camel@localhost.localdomain> <20060119223251.GB27106@kroah.com>
In-Reply-To: <20060119223251.GB27106@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2006.01.20.033120
X-PerlMx-Spam: Gauge=, SPAM=1%, Reasons='EMC_FROM_00+ -3, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Thu, Jan 19, 2006 at 10:14:56PM +0000, Alan Cox wrote:
>  
>
>>On Iau, 2006-01-19 at 14:04 -0800, Greg KH wrote:
>>    
>>
>>>Ah, ok, thanks, that makes sense.  How about a simple pointer to the
>>>license info from the .S files to the README file so that people (like
>>>me), don't get confused again?  I've attached a patch below if you wish
>>>to apply it.
>>>
>>>      
>>>
>>They specifically ask as is their right within the GPL that you note if
>>you modify the files. Otherwise seems fine.
>>    
>>
>
>Hm, any idea on how to note that I modified the file in such a way that
>would be acceptable?  How about this?
>
>+|
>+|      For details on the license for this file, please see the
>+|      file, README, in this same directory.  Note, this paragraph in
>+|	this comment has been added from the original version of this
>+|	file from the author.
>
>thanks,
>
>greg k-h
>  
>
The language in the source files is pretty strong and this looks like Motorola should be asked to rerelease the files with a normal copyright notice in place of the current language...


ric



