Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWAZQFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWAZQFK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWAZQFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:05:10 -0500
Received: from mail.gmx.de ([213.165.64.21]:57489 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751008AbWAZQFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:05:08 -0500
X-Authenticated: #428038
Message-ID: <43D8F327.6060800@gmx.de>
Date: Thu, 26 Jan 2006 17:04:55 +0100
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, grundig@teleline.es, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <43D8988F.nailDTH21LS0G@burner> <1138268759.3087.138.camel@mindpipe> <43D8D5A0.nailE2X71H31H@burner> <43D8D80B.9080203@yahoo.com.au> <43D8DD7B.nailE2XL1KRWJ@burner>
In-Reply-To: <43D8DD7B.nailE2XL1KRWJ@burner>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>> Joerg Schilling wrote:
>>> Lee Revell <rlrevell@joe-job.com> wrote:
>>>
>>>
>>>>> Interesting: You claim that the Linux platform provides ways to retrieve 
>>>>> the needed information on FreeBSD, MS-WIN, ....?
>>>>>
>>>> What do FreeBSD and MS-WIN have to do with Linux?
>>>
>>> What is the relevence of /dev/hd* for a device independent library like libscg?
>>>
>> Isn't it good practice to adhere to the naming conventions
>> of the system to which a program is ported to? (even if 100
>> of them do it one way and 1 does it another)
> 
> Well, the problem is that (in special if you include the ATAPI tape drives)
> Linux likes to enforce inapropriate naming conventions.

Nope. Naming conventions are not subject here.

What OTHER libscg operations do not work for a particular ATAPI tape drive?
-scanbus does NOT count, don't mention it.
What is the drive manufacturer and type?
What is the failing or inaccessible operation?

Please remember to remove Jens Axboe and Lee Revell from the Cc: list!
