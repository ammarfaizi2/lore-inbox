Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272179AbRH3MRc>; Thu, 30 Aug 2001 08:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272173AbRH3MR2>; Thu, 30 Aug 2001 08:17:28 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:17606 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S272179AbRH3MRO>; Thu, 30 Aug 2001 08:17:14 -0400
Date: Thu, 30 Aug 2001 22:17:33 +1000
From: john slee <indigoid@higherplane.net>
To: Philippe Amelant <philippe.amelant@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp freeze on 2.4.9
Message-ID: <20010830221733.A3834@higherplane.net>
In-Reply-To: <999166237.1257.31.camel@avior>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <999166237.1257.31.camel@avior>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 12:10:37PM +0200, Philippe Amelant wrote:
> I have an ABIT BP6 mobo with 2 celeron 400 running redhat 7.1 with 2.4.3

before you blame smp, try the usual bp6 stuff:
*	bigger/better power supply
*	better cooling
*	boot with 'noapic' on commandline

search a linux-kernel archive (http://marc.theaimsgroup.com)
for more info.  these boards seem to be a bit of a lucky dip.  some
never have any problems, others have heaps.  i have a vague memory of
someone mentioning flaky caps on some revisions...  also are you using
the onboard ata66 controller?  there's been a fair few reports of
trouble with those, not sure if it was fixed/hacked-around or not.

best of luck,

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
