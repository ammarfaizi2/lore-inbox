Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266567AbTGKAoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269709AbTGKAoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:44:14 -0400
Received: from mail-05.iinet.net.au ([203.59.3.37]:26116 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266567AbTGKAoM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:44:12 -0400
Message-ID: <3F0E097F.1080601@ii.net>
Date: Fri, 11 Jul 2003 08:49:03 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.75
References: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>	<1057879835.584.7.camel@teapot.felipe-alfaro.com>	<1057880428.1984.12.camel@localhost> <20030711022446.0ef98986.diegocg@teleline.es>
In-Reply-To: <20030711022446.0ef98986.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja García wrote:

>El 10 Jul 2003 16:40:29 -0700 Robert Love <rml@tech9.net> escribió:
>
>  
>
>>I do not see it as a _huge_ problem, because we are just worrying about
>>corner cases now. Worst case we can turn off the interactivity estimator
>>- which is both the root of the improvement and the problems - and be
>>back to where we are in 2.4.
>>    
>>
>
>It used to work fine in the past; now as Felipe said, it's a PITA. Con's
>patch helps but it's not even near than what it used to be. My make -j 25
>without any skip is now -j3 with Con's patch and some mp3 skips. Perhaps
>i should start testing when it stopped "working" (i always save the kernel
>images)
>  
>
Please share this information if you find it :-) I would like a nice 
desktop kernel again too.

>Diego Calleja
>
>  
>


