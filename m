Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272706AbRISWD7>; Wed, 19 Sep 2001 18:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274204AbRISWDj>; Wed, 19 Sep 2001 18:03:39 -0400
Received: from ns.caldera.de ([212.34.180.1]:34758 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S274202AbRISWDf>;
	Wed, 19 Sep 2001 18:03:35 -0400
Date: Thu, 20 Sep 2001 00:03:20 +0200
Message-Id: <200109192203.f8JM3Kh10663@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: greearbxu@candelatech.com (Ben Greear)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Replace the eepro100 driver with the e100 driver??
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3BA90EF2.527C9A50@candelatech.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BA90EF2.527C9A50@candelatech.com> you wrote:
> The e100 license appears to be compatible, and it has some nice features, like
> interrupt-cooelescing that I don't think are supported in the eepro100..
>
> I keep thinking that if everyone could get behind a single driver,
> especially one with corporate support, we may have a more stable
> result...
>
> Here's the license:

Even if the license were compatible (it isn't) I wouldn't ever choose
to replace eeproo100 with e100 - whilst eeproo100 is a rather nice
behaving Linux driver, e100 is an utter piece of crap.  Never seen
a driver so full of interface violations, wrong types, races, bugs,
etc..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
