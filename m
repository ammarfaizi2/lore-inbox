Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSGJQvE>; Wed, 10 Jul 2002 12:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317546AbSGJQvD>; Wed, 10 Jul 2002 12:51:03 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:25094 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S317544AbSGJQvB>; Wed, 10 Jul 2002 12:51:01 -0400
Message-ID: <3D2C66D9.AF14035A@opersys.com>
Date: Wed, 10 Jul 2002 12:54:49 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Adrian Bunk <bunk@fs.tum.de>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       bob <bob@watson.ibm.com>, Richard Moore <richardj_moore@uk.ibm.com>
Subject: Re: [STATUS 2.5]  July 10, 2002
References: <Pine.LNX.4.44.0207101027380.5067-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thunder from the hill wrote:
> > >    - Build option for Linux Trace Toolkit (LTT)
> 
> Nobody seemed to be interested in this toolkit. The (s|l)trace toolkit and
> kdb seemed to be sufficient for the most developers. (I don't whine here
> either.)

It's somewhat unfair to compare LTT to s/ltrace or kdb because they
don't serve the same purposes. The other thread on "Enhanced profiling"
should have made this very clear by now.

I've spoken to many key kernel developers about this and they all saw
its inclusion as being positive, but they also all said the same thing:
it's really Linus' decision.

In light of the recent discussions, it would be really nice to get a
definitive statement about LTT's inclusion in 2.5.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
