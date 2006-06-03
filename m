Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWFCW5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWFCW5h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 18:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWFCW5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 18:57:37 -0400
Received: from smtpout08-04.prod.mesa1.secureserver.net ([64.202.165.12]:14211
	"HELO smtpout08-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1751817AbWFCW5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 18:57:37 -0400
Message-ID: <448213DF.4030506@seclark.us>
Date: Sat, 03 Jun 2006 18:57:35 -0400
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: wine-devel-request@winehq.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alsa sound vs OSS with wine and riven
References: <4481E816.4090600@seclark.us> <1149367697.28744.45.camel@mindpipe>
In-Reply-To: <1149367697.28744.45.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Sat, 2006-06-03 at 15:50 -0400, Stephen Clark wrote:
>  
>
>>Hello,
>>
>>I have been working to get "Riven" the sequel to Myst to work with
>>the 
>>latest wine from cvs on the latest FC5. It works and the sound is
>>almost perfect with 
>>OSS, but is totally screwed up when I use ALSA, I don't know whether
>>this is a WINE or Linux 
>>issue, so I am cross posting to both lists.
>>    
>>
>
>Does it work with ALSA's OSS emulation?
>
>Lee
>
>
>  
>
Actually looking at the .config file it looks like it is using OSS 
emulation - not real OSS.

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



