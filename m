Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbUJ0IX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbUJ0IX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbUJ0IX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:23:57 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:59852 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262327AbUJ0IXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:23:55 -0400
Message-ID: <47815.195.245.190.93.1098865388.squirrel@195.245.190.93>
In-Reply-To: <200410262209.30332.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20041022155048.GA16240@elte.hu>
    <200410260827.39888.vda@port.imtp.ilyichevsk.odessa.ua>
    <62112.195.245.190.94.1098787213.squirrel@195.245.190.94>
    <200410262209.30332.vda@port.imtp.ilyichevsk.odessa.ua>
Date: Wed, 27 Oct 2004 09:23:08 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 27 Oct 2004 08:23:53.0890 (UTC) FILETIME=[4BAC8020:01C4BBFE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Denis Vlasenko wrote:
>> >
>> > <shameless plug>
>> > Maybe this program will be useful. It is designed to give you
>> > overall system statistics without the need to scan entire /proc/NNN
>> > forest. Together with nice -20, it will hopefully not stall.
>> >
>> > Compiled with dietlibc. If you will have trouble compiling it,
>> > binary is attached too.
>> >
>> > Latest version is 0.9 but it seems I forgot it in my home box :(
>> </shameless plug>
>>
>> Thanks for nmeter. I have changed a couple of little bits to build with
>> gcc-3.4 here (see diff attached).
>
> Hmm will it compile on 3.4 with "static inline"?
>

Yes, it now compiles on gcc-3.4.1 out of the box.

Thanks for this nice little utility.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

