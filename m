Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTI0QRs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 12:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTI0QRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 12:17:48 -0400
Received: from compunauta.com ([69.36.170.169]:53901 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S262491AbTI0QRr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 12:17:47 -0400
From: Gustavo Guillermo <gustavo@compunauta.com>
Date: Sat, 27 Sep 2003 05:18:38 GMT
Message-ID: <20030927.5183800.688813666@linux.local>
Subject: Re: cpu 100% constantly..
To: =?ISO-8859-1?Q?B=F6rkur?= Ingi =?ISO-8859-1?Q?J=F3nsson?= 
	<bugsy@isl.is>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200309260157.30018.bugsy@isl.is>
References: <200309260157.30018.bugsy@isl.is>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO_8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I Have the same problem too but with 2.4.23-pre4
System, reach to hang up about 2 or 3 seconds and puts sound server down.
I doubt that is or not kernel issue, because sometimes it never happens.
With my old kernel 2.4.21-pre5 works fine.

This is not related to sound server (arts) because is a time issue on
arts (you can reproduce it putting back your system clock), but kernel
doesn't said anything at respect.

I trying to find out which driver or process is guilty.





>>>>>>>>>>>>>>>>>> Mensaje original <<<<<<<<<<<<<<<<<<

El 26/09/03, 7:57:29, Börkur Ingi Jónsson <bugsy@isl.is> escribió sobre el
tema cpu 100% constantly..:


> I just installed kernel 2.6-beta 5 and I noticed my kde was kinda slow. I
then
> saw that cpu was in 100% usage while doing nothing. I never reported any
bug
> to the linux kernel before. What kind of info should I put in such a
report
> and more importantly how do I get that info :). Should I post the bug
here or
> in some bug database?

>  Regards, Börkur Ingi Jónsson

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
