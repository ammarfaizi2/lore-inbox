Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUFRJG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUFRJG1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265052AbUFRJEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:04:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:21508 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265084AbUFRIsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 04:48:05 -0400
Message-ID: <40D2ACED.3060404@hist.no>
Date: Fri, 18 Jun 2004 10:50:53 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 4Front Technologies <dev@opensound.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com>	 <77709e76040617180749cd1f09@mail.gmail.com>	 <40D24163.5000006@opensound.com> <1087522622.5475.30.camel@louise3.6s.nl> <40D24963.7040003@opensound.com>
In-Reply-To: <40D24963.7040003@opensound.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4Front Technologies wrote:

> Bastiaan Spandaw wrote:
>
>>
>> The distributions you named earlier all patch the kernels they ship with
>> their distribution.
>>
>> There's only a handfull that install a vanilla kernel by default (out of
>> the >200 distributions available)
>>
>> debian, redhat & gentoo patch their kernels.
>>
>>
>> Is your problem that a kernel is not the kernel.org vanilla version? (If
>> so have a fit @ debian, redhat and gentoo as well )
>>
>
> Redhat/Debian/Gentoo do the right thing by the kernel from 
> www.kernel.org.
>
>> Or that Suse's does not work with your income generating product?
>>
> We can fix our problems. It's just that it's becomming a treadmill.

Consider getting your driver into the standard kernel - then you get less
problems with header changes. (Those who change headers usually
keep the standard tree working.)  If you want to keep a driver for yourself
though, then you need to keep fixing it continously jsut to keep up with
the standard kernel.  And if you want SUSE customers, then you need to
keep up with their patches too.  An so on for all the other distributions.

> What's with you guys?. Would you really like to see Linux forking?

_Why not_?  It is not something I worry about.  Forks happen, but
go away as the forked stuff either is merged back into the std. kernel
(if it is good) or becomes obsolete after a few months.  Anyone who
maintains their own fork get the burden of keeping up with
Linus - this limits the forking.

Helge Hafting



>
>
>
> best regards
>
> Dev Mazumdar
> ---------------------------------------------------------------------
> 4Front Technologies
> 4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
> Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
> ---------------------------------------------------------------------
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


