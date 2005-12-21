Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVLUSLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVLUSLz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVLUSLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:11:55 -0500
Received: from mail.scienion.de ([141.16.81.54]:57479 "EHLO
	sci36-01.hq.scienion.de") by vger.kernel.org with ESMTP
	id S932486AbVLUSLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:11:54 -0500
Message-ID: <43A99AE0.5070005@scienion.de>
Date: Wed, 21 Dec 2005 19:11:44 +0100
From: Sebastian Kloska <kloska@scienion.de>
Organization: Scienion AG
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: vfat question
References: <200512211602.jBLG2QKM003368@laptop11.inf.utfsm.cl>	<43A981FD.5030202@scienion.de> <20051221104321.1d02ca43.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <20051221104321.1d02ca43.Tommy.Reynolds@MegaCoder.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 thanks...

Tommy Reynolds wrote:

>Uttered Sebastian Kloska <kloska@scienion.de>, spake thus:
>
>Please do not set the reply-to: mail header when sending to a mailing
>list.  Thanks.
>
>  
>
>> I have to admit I do not even have a clue how to get access to
>> the directory table of a mounted vfat device. The whole idea
>> is for manipulating the ordering of mp3-players which
>> (on some devices) seems to dictate the play order.
>> So if someone could point me to a good documentation
>> I would appreciate it.
>>    
>>
>
>Accessing a mounted VFAT for this is probably not a good idea.
>
>However, a userland solution should be possible and much easier than
>trying this from the kernel.
>
>Look at the mtools package:
>
>	http://www.gnu.org/software/mtools/mtools.html
>
>where you should find tools that do such access already.  Then, start
>hacking the mdir(1) tool, or some such, to sort the VFAT orders
>however you like them.
>
>Cheers
>  
>


-- 
**********************************
Dr. Sebastian Kloska
Head of Bioinformatics
Scienion AG
Volmerstr. 7a
12489 Berlin
phone: +49-(30)-6392-1747
fax:   +49-(30)-6392-1701
http://www.scienion.de
**********************************

