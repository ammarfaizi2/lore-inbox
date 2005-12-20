Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVLTA41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVLTA41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 19:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVLTA41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 19:56:27 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:9934 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750722AbVLTA40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 19:56:26 -0500
Date: Mon, 19 Dec 2005 19:56:25 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: -rc6 vs desktop use, desktop 0
In-reply-to: <200512191808.18784.gene.heskett@verizon.net>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200512191956.25352.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512191808.18784.gene.heskett@verizon.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 December 2005 18:08, Gene Heskett wrote:
>Greetings;
>
>I tried to rebuild rc6 without the size optimizations, but that
>resulted in some sort of a timer problem being logged at about 1
>second intervals to the vt's.
>
>I'm back in rc5 now, cause rc6 is best described as a dog for desktop
>use, kmail freezes for 10 seconds at a time.  rc5 does do that nearly
>as bad.
>
>Useing Con's scheduler as default in both cases.

Humm, no comment from anyone so far.  Do you need more data? i686
(athlon) cpu, gig of ram, what else do you need? 

I could attach the .config I suppose. I did look to see if an option 
had been added to use the desktop/server versions of Cons newer 
patches, but its not visible in a make xconfig.  Is this something 
thats going to be needed, or should I switch scheduelers?

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should use this
address: <gene.heskett@verizononline.net> which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
