Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287141AbSA0Npz>; Sun, 27 Jan 2002 08:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287633AbSA0Nps>; Sun, 27 Jan 2002 08:45:48 -0500
Received: from [195.63.194.11] ([195.63.194.11]:35341 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287141AbSA0Npd>; Sun, 27 Jan 2002 08:45:33 -0500
Message-ID: <3C54046D.7020305@evision-ventures.com>
Date: Sun, 27 Jan 2002 14:45:17 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: patch: sysctl.h (allocating new number)
In-Reply-To: <3C51146F.6774.15F75C@localhost> <a2smpo$23l$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

>Followup to:  <3C51146F.6774.15F75C@localhost>
>By author:    "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
>In newsgroup: linux.dev.kernel
>
>>I have implemented sysctl extensions to read/write the ``tick'' and 
>>slew rate of adjtime() (among others) for my new kernel clock model 
>>using nanoseconds (PPSkit-2.0.1). If there's demand to a back-merge to 
>>the main stream sources, plese say what you would like. As the project 
>>was sponsored a little bit recently, I'm willing to donate a few 
>>working hours for that.
>>
>
>I, for one, would definitely see the clock model merged into the
>mainstream kernel.
>
>	-hpa
>
Amen to this!

I, for two, would definitely like to see it there as well!



