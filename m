Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbSLPL6e>; Mon, 16 Dec 2002 06:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266627AbSLPL6e>; Mon, 16 Dec 2002 06:58:34 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:40907 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S266564AbSLPL6c>; Mon, 16 Dec 2002 06:58:32 -0500
Date: Tue, 17 Dec 2002 00:57:32 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Greg KH <greg@kroah.com>, Colin Paul Adams <colin@colina.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Alcatel speedtouch USB driver and SMP.
Message-ID: <3880000.1040039852@localhost.localdomain>
In-Reply-To: <20021216051300.GB12884@kroah.com>
References: <m3n0n7hi52.fsf@colina.demon.co.uk>
 <20021215075913.GB2180@kroah.com> <m3hedfhd5l.fsf@colina.demon.co.uk>
 <20021216051300.GB12884@kroah.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a binary only one from Alcatel themselves, which only works on one 
2.2 kernel and one (old) 2.4 kernel, the other is on SourceForge, and is 
also GPL.

Andrew, who's just set up one himself on 2.4 and will try 2.5 when enough 
else behaves.

--On Sunday, December 15, 2002 21:13:00 -0800 Greg KH <greg@kroah.com> 
wrote:

> On Sun, Dec 15, 2002 at 08:58:14AM +0000, Colin Paul Adams wrote:
>> >>>>> "Greg" == Greg KH <greg@kroah.com> writes:
>>
>>     Greg> On Sun, Dec 15, 2002 at 07:10:33AM +0000, Colin Paul Adams
>>     Greg> wrote:
>>     >> Can anyone tell me if the speedtouch driver is SMP safe yet?
>>
>>     Greg> Which driver?  I know of at least 3 different ones :(
>>
>> drivers/usb/misc/speedtouch.c
>
> Ah good, you're using one that the source is available for :)
> I think the developer has said it will work on SMP machines, but what
> problems are you having, and have you asked the author of the code?
>
>> Where are the others?
>
> I don't know, but I know they are out there...
>
> thanks,
>
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


