Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289910AbSAKJ3a>; Fri, 11 Jan 2002 04:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289908AbSAKJ3V>; Fri, 11 Jan 2002 04:29:21 -0500
Received: from [195.63.194.11] ([195.63.194.11]:29970 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S289910AbSAKJ3A>; Fri, 11 Jan 2002 04:29:00 -0500
Message-ID: <3C3EB047.3000201@evision-ventures.com>
Date: Fri, 11 Jan 2002 10:28:39 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Andris Pavenis <pavenis@latnet.lv>, tom@infosys.tuwien.ac.at,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio driver v0.19 still freezes machine
In-Reply-To: <200201101058.g0AAwJH00606@hal.astr.lu.lv> <3C3DDA8B.4090004@redhat.com>
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> Andris Pavenis wrote:
>
>> I found that i810_audio driver v0.19 from 
>>     http://people.redhat.com/dledford/i810_audio.c.gz
>> still freezes machine after /dev/dsp is being closed (printk at end 
>> of i810_release()). It doesn't happen always though.
>
>
>
> I'm unable to duplicate this (the current 0.19 driver doesn't hang at 
> all on me now under any of my tests).  Try to find a way to duplicate 
> it (either by playing a specific wav file using the play command, or 
> by doing something in particular to make artsd do it, or something 
> else).  If you can find a way to duplicate it, then I can see about 
> getting a proper fix for it. 

Just for the record:
18 works for me even in the context of KDE and artsd without any flaws. 
(SiS735 board).

>
>



