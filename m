Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265366AbRGEPN6>; Thu, 5 Jul 2001 11:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbRGEPNx>; Thu, 5 Jul 2001 11:13:53 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:42733 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S265347AbRGEPM6>; Thu, 5 Jul 2001 11:12:58 -0400
Date: Thu, 05 Jul 2001 11:12:56 -0400
From: Alan Shutko <ats@acm.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <0107051704000H.03760@starship>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Xavier Bestel <xavier.bestel@free.fr>, Dan Maas <dmaas@dcine.com>,
        linux-kernel@vger.kernel.org, Tom spaziani <digiphaze@deming-os.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>
Message-id: <8766d7s93s.fsf@wesley.springies.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.103
In-Reply-To: <fa.jprli0v.qlofoc@ifi.uio.no> <0107051502510F.03760@starship>
 <994341617.2070.1.camel@nomade> <0107051704000H.03760@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> writes:

> Also, notice that the scenario we were originally discussing, the off-hours 
> updatedb, doesn't normally happen on laptops because they tend to be 
> suspended at that time.

No, even worse, it happens when you open the laptop for the first time
in the morning, thanks to anacron.

-- 
Alan Shutko <ats@acm.org> - In a variety of flavors!
For children with short attention spans: boomerangs that don't come back.
