Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSCRQjB>; Mon, 18 Mar 2002 11:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSCRQiw>; Mon, 18 Mar 2002 11:38:52 -0500
Received: from [195.63.194.11] ([195.63.194.11]:20996 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287204AbSCRQii>; Mon, 18 Mar 2002 11:38:38 -0500
Message-ID: <3C9617BB.8030205@evision-ventures.com>
Date: Mon, 18 Mar 2002 17:37:15 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: some ide-scsi commands starve drives on the same cable
In-Reply-To: <E16mIEq-0006nO-00@the-village.bc.nu> <3C95E7E3.4020300@evision-ventures.com> <E16n022-000880-00@mrvdomng2.kundenserver.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:
> Martin Dalecki wrote:
> 
>>>There has been some movement forward in the standards on this. You might
>>>want to ask our new 2.5 IDE maintainer if/when it will be implemented - I
>>>suspect you have to wait a while though. There is much IDE to clean up
>>>first
>>
>>Just for the record: I'm aware of it.
> 
> 
> Good to hear that.
> 
> But I guess this is future work and will never get into 2.4, right?

It is future work yes. I don't intend to care about 2.4. Since the 2.4 is
leaking the BIO stuff it will be quite hard to backport the IDE stuff if
someone (not me) attempts to.

> Bytheway, as you became the IDE maintainer for 2.5, who is the IDE maintainer 
> for 2.4? Andre?

Yes.

