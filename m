Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbVIZAC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbVIZAC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 20:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbVIZAC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 20:02:58 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:19431 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S1751573AbVIZAC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 20:02:58 -0400
Message-ID: <43373AAA.8050203@blueyonder.co.uk>
Date: Mon, 26 Sep 2005 01:02:50 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ktimers subsystem
References: <4336C6D8.4090602@blueyonder.co.uk> <Pine.LNX.4.61.0509251120080.1684@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0509251120080.1684@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2005 00:03:40.0663 (UTC) FILETIME=[C05E0070:01C5C22D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sun, 25 Sep 2005, Sid Boyce wrote:
> 
> 
>>OT, but something that's been bugging me for quite a while.
>>I cut and paste the patch from the email to a file ktimers.patch.
>>"# patch -l -p1 <ktimer.patch" and it returns ---
>> (Patch is indented 1 space.)
>>patching file fs/exec.c
>>patch: **** malformed patch at line 16: }
>>
>>If I prepend 2 tabs to the line, it complains about line 17, I do the same to
>>line 17 and on it moves to the next. from the manpage it reads like the "-l"
>>should take care of the tabs so it only compares the text.
>>Can anyone suggest how to apply the patch? Googling didn't help.
> 
> 
> Save the entire email as a text file and apply it. Cut and paste usually 
> introduces white space damage.
> 
> 
> 

Thanks.
regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
