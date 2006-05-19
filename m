Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWESOeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWESOeI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 10:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWESOeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 10:34:08 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:16316 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932316AbWESOeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 10:34:07 -0400
Message-ID: <446DD75D.8050203@dgreaves.com>
Date: Fri, 19 May 2006 15:34:05 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       linux cbon <linuxcbon@yahoo.fr>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
References: <20060518172827.73908.qmail@web26601.mail.ukl.yahoo.com> <446D8F36.3010201@aitel.hist.no> <446DA746.50506@lumumba.uhasselt.be>
In-Reply-To: <446DA746.50506@lumumba.uhasselt.be>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:
> Hi,
>
> Helge Hafting wrote:
>
>> [...]
>> The problem with writing those 3D drivers is not complexity
>> or "historic baggage" in the X codebase.  It is the fact that
>> only the vendors know how the cards work, and most of them
>> won't tell us.
>>
>> To which the solution is:  buy the cards that work, and screw the rest. 
>
> Just out of curiosity: Do you know any currently sold cards that support
> XVideo, OpenGL and for which open source drivers are available?
>
> With friendly regards,
> Takis
Almost all ATI cards :)

What you mean is 'that use hardware acceleration to achieve useful
results' (like playing NeverWinter Nights or watching MythTV).

I think the ATI Radeon 9250 is the best graphics card still available
that has an open source driver (X.org radeon r250/r280 driver). This
works nicely with the 2.6.16 kernels. The 9250 isn't actually mentioned
in Google results very much and it seems to be more widely available
than the slightly older 9200.

I recently bought 2 for exactly this reason.

Then one failed and the supplier kindly sent me an upgraded version, a
9600 IIRC - but the r300 driver isn't out yet - in X.org 7 maybe - and
it seems incomplete anyway - so I had to send it back and ask for a
'downgrade' which confused them.

HTH

David

PS My wife removed her shiny new (expensive) ATI 9800 card and replaced
it with a 9250 and although the performance dropped she found that
having a driver that let her machine run accelerated graphics for over 5
minutes at a time was a serious benefit. The open source driver was
simply *much* more stable.
Anyone want a spare ATI 9800 :)
(just kidding - I'll test the r300 driver as soon as I get the chance!)

-- 

