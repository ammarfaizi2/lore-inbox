Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317808AbSFSHy6>; Wed, 19 Jun 2002 03:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317809AbSFSHy5>; Wed, 19 Jun 2002 03:54:57 -0400
Received: from [195.63.194.11] ([195.63.194.11]:65036 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317808AbSFSHy4> convert rfc822-to-8bit; Wed, 19 Jun 2002 03:54:56 -0400
Message-ID: <3D1038CC.3090108@evision-ventures.com>
Date: Wed, 19 Jun 2002 09:54:52 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Garet Cammer <arcolin@arcoide.com>, linux-kernel@vger.kernel.org
Subject: Re: Need IDE Taskfile Access
References: <Pine.SOL.4.30.0206182120100.23983-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Bartlomiej Zolnierkiewicz napisa³:
> Do not worry Garet, I will reimplement it later in 2.5.
> I need some free time to do it, (maybe next month?).

First the main things have to stabilize.
And please note that using the SMART commands *is
possible* in 2.5 (modulo bugs and mistakes like for
example 92... argh...). I'm checking regularly
whatever ide-smart still works.

> On Tue, 18 Jun 2002, Andre Hedrick wrote:

>>You are wasting electons, the interface is gone and the API to the
>>transport is wrecked.  I will need to compose a loadable module to renable
>>the support.  Clearly 2.5/2.6 is not friendly with the needs of the
>>industry and it will never be at this rate.

If the "industry" asks - I'm responsive for certain.
Unless not - I don't.

> Will be...
> 
>>In the end, I will end up writing a closed ATA binary driver for sale as a
>>replacement.  I have had several requests to consider the option.  As much
>>as I do not like the idea, it is less offensive than the current
>>direction.
> 
> 
> Ugh, please dont...

Let him do. Why not? Sounds lake a sane business plan.



