Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbVIAOIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbVIAOIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbVIAOIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:08:48 -0400
Received: from ctb-mesg9.saix.net ([196.25.240.89]:48838 "EHLO
	ctb-mesg9.saix.net") by vger.kernel.org with ESMTP id S965121AbVIAOIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:08:47 -0400
Message-ID: <43170AF0.7060703@geograph.co.za>
Date: Thu, 01 Sep 2005 16:06:40 +0200
From: Zoltan Szecsei <zoltans@geograph.co.za>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Svetoslav Slavtchev <svetljo@gmx.de>
CC: lkml <linux-kernel@vger.kernel.org>,
       Aivils Stoss <aivils@users.sourceforge.net>
Subject: Re: multiple independent keyboard kernel support
References: <3531.1125581750@www27.gmx.net>
In-Reply-To: <3531.1125581750@www27.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Svetoslav Slavtchev wrote:

>Hi,
>sorry for replying in this way, but i'm not subscribed
>to lkml, and please do CC me
>
>ruby is still maintained and the list is pretty active
>although that is mostly volunteer work from Aivils
>  
>
Thats good. Googling for it I found too many hits, and the ones I looked 
at were all older than Dec 2003.

>it's running pretty stable on x86 and x86_64
>and there are patches almost all recent 2.6 kernels (upto 2.6.12)
>  
>
excellent - I'm running 2.6.11-21.8 (SuSE 9.3)

>and IIRC another person is maintaing the backport to linux-2.4
>
>please check out this site : http://www.ltn.lv/~aivils/
>  
>
Have bookmarked it - thanks.

>best,
>
>svetljo
>
>PS.
>from user experiances, i doubt you'll be able to get it
>running with onboard graphic or with "fake" multihead card
>  
>
Not an issue - I intend to use onboard and 2 PCI (nvidia FX5200 based) 
cards. (or maybe even 2 PCIExpress in discreet mode on a mobo with 2 
slots. - dont know yet....)

>/* under "fake" i do understand almost all cards on the market
> that are dualhead, and under "real" Matrox's G200/G450 MMS
> which do have 4 real chips on it */
>  
>
Yes - I understand this too and I have also noted that this doesn't 
work. ie: you *need* seperate graphics controllers.

Cheers & many thanks for the pointers,
Zoltan


-- 

==================================
Geograph (Pty) Ltd
P.O. Box 31255
Tokai
7966
Tel:    +27-21-7018492
Fax:	+27-86-6115323
Mobile: +27-83-6004028
==================================


