Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVAKN3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVAKN3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 08:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVAKN3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 08:29:20 -0500
Received: from host234-143.pool8250.interbusiness.it ([82.50.143.234]:42113
	"EHLO zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S262752AbVAKN3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 08:29:12 -0500
Message-ID: <41E3D37A.2030303@abinetworks.biz>
Date: Tue, 11 Jan 2005 14:24:10 +0100
From: "Ing. Gianluca Alberici" <alberici@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prarit Bhargava <prarit@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Bad disks or bug ?
References: <41E3C90A.2010703@abinetworks.biz> <20050111130005.GB87982@king.bitgnome.net> <41E3CE5A.3000008@abinetworks.biz> <41E3D2A7.3000002@sgi.com>
In-Reply-To: <41E3D2A7.3000002@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prarit,

I run 2.4.27 on all my machines.

Never had problems but this (if we want to say its not a disk problem)

I have seen on mailing lists many people having this very problem, 
always on hdb, with a lot of different kernel and machines.

I have basically two kind of cabinets:

- The 'Antec style' tower
- Racmount cases

Everything well cooled...i am sure bout that.

Always ASUS A7V, Athlon XP 2xxx+, NEVER OVERCLOCKED, of course...

Disks are mainly Maxtor, or IBM

Basically i was wondering whether to swap disks on a server just to try....

....These are the things that rave me mad !


Prarit Bhargava wrote:

> Hi Gianluca,
>
> How old is your kernel?
> P.
>
> Ing. Gianluca Alberici wrote:
>
>> Hello,
>>
>> Very Interesting news from Massimo...
>>
>> About the heat source, Mark, i thought about that, too, and hdb is 
>> always the
>> bottom (CS Enabled) device of rackmounts (so the colder one) , in front
>> of the usual ball bearing fans !!!!
>>
>> I am beginning to believe all this deserves a more deep investigation...
>>
>> Waiting for comments,
>>
>> Gianluca
>>
>> Mark Nipper wrote:
>>
>>> On 11 Jan 2005, Ing. Gianluca Alberici wrote:
>>>  
>>>
>>>> How do you explain that ? Overload on hdb due to mirroring and surface
>>>> degradation ?
>>>> OR a kind of vodoo on my hdbs ?
>>>>   
>>>
>>>
>>>
>>>     Is it possible that hdb is closer to a high heat source
>>> or is not being cooled as hda if all these machines are the same
>>> case design?
>>>
>>>  
>>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
