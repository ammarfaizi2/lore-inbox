Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265327AbRGEPFh>; Thu, 5 Jul 2001 11:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265310AbRGEPFS>; Thu, 5 Jul 2001 11:05:18 -0400
Received: from front1.grolier.fr ([194.158.96.51]:54766 "EHLO
	front1.grolier.fr") by vger.kernel.org with ESMTP
	id <S265315AbRGEPFO>; Thu, 5 Jul 2001 11:05:14 -0400
Subject: Re: VM Requirement Document - v0.0
From: Xavier Bestel <xavier.bestel@free.fr>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org,
        Tom spaziani <digiphaze@deming-os.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <0107051704000H.03760@starship>
In-Reply-To: <fa.jprli0v.qlofoc@ifi.uio.no> <0107051502510F.03760@starship>
	<994341617.2070.1.camel@nomade>  <0107051704000H.03760@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 05 Jul 2001 17:00:31 +0200
Message-Id: <994345246.2790.0.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Jul 2001 17:04:00 +0200, Daniel Phillips wrote:
> > Well, on a laptop memory and disk bandwith are rarely wasted - they cost
> > battery life.
> 
> Let me comment on this again, having spent a couple of minutes more 
> thinking about it.  Would you be happy paying 1% of your battery life to get 
> 80% less sluggish response after a memory pig exits?

Told like this, of course I agree !

> Also, notice that the scenario we were originally discussing, the off-hours 
> updatedb, doesn't normally happen on laptops because they tend to be 
> suspended at that time.

Suspended != halted. The updatedb stuff starts over when I bring it back
to life (RH6.2, dunno for other distribs)

Xav

