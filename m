Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265310AbRGEPJs>; Thu, 5 Jul 2001 11:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265326AbRGEPJi>; Thu, 5 Jul 2001 11:09:38 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:43280 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265310AbRGEPJU>; Thu, 5 Jul 2001 11:09:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: VM Requirement Document - v0.0
Date: Thu, 5 Jul 2001 17:12:54 +0200
X-Mailer: KMail [version 1.2]
Cc: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org,
        Tom spaziani <digiphaze@deming-os.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <fa.jprli0v.qlofoc@ifi.uio.no> <0107051704000H.03760@starship> <994345246.2790.0.camel@nomade>
In-Reply-To: <994345246.2790.0.camel@nomade>
MIME-Version: 1.0
Message-Id: <0107051712540I.03760@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 July 2001 17:00, Xavier Bestel wrote:
> On 05 Jul 2001 17:04:00 +0200, Daniel Phillips wrote:
> > Also, notice that the scenario we were originally discussing, the
> > off-hours updatedb, doesn't normally happen on laptops because they tend
> > to be suspended at that time.
>
> Suspended != halted. The updatedb stuff starts over when I bring it back
> to life (RH6.2, dunno for other distribs)

Yes, but then it's normally overlapped with other work you are doing, like 
trying to read your mail.  Different problem, one we also perform poorly at 
but for different reasons.

--
Daniel
