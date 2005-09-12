Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVILHB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVILHB1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVILHB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:01:27 -0400
Received: from ctb-mesg4.saix.net ([196.25.240.84]:26021 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S1751186AbVILHB0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:01:26 -0400
Message-ID: <432527B7.4070506@geograph.co.za>
Date: Mon, 12 Sep 2005 09:01:11 +0200
From: Zoltan Szecsei <zoltans@geograph.co.za>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiple independent keyboard kernel support
References: <4316E5D9.8050107@geograph.co.za> <20050911223414.GA19403@aitel.hist.no>
In-Reply-To: <20050911223414.GA19403@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

>>I would prefer to see "official and permanent" support for this as then 
>>when HW & drivers & kernels develop in the future, this capability will 
>>always be (immediately) available - and not have to wait for patches.
>>
>>    
>>
>
>"evdev" in the kernel already separates out independent keyboards.
>Isolatedevice lets several xservers run indepenmdently.  There isn't
>much missing, although there are minor troubles where starting one
>xserver might mess up the video timing for another.  (Solution:
>start xserver in an appropriate order, to be found by experimentation)
>Another minor problem - it won't work with every combination of video cards,
>only some.
>Still - when it works you even get to run accelerated 3D on
>the independent heads.  Nice for game parties.
>
>  
>
This is by far the best news I could have hoped for.

>>    
>>
>I hope this helps.
>  
>
Definitely yes.
Helge, thank you very much for taking the time to respond to my 
(lengthy) query. I will be away for a few weeks, but will try this in 
full during early October.

I have in the meantime unsubscribed from linux-kernel so please use my 
direct address if you need to discuss anything further.

Kind regards,
Zoltan


>Helge Hafting
>
>
>  
>


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


