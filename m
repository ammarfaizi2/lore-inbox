Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWGGNun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWGGNun (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWGGNun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:50:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19717 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751186AbWGGNum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:50:42 -0400
Date: Fri, 7 Jul 2006 13:50:31 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net
Subject: Re: swsusp / suspend2 reliability
Message-ID: <20060707135031.GA4239@ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627154130.GA31351@rhlx01.fht-esslingen.de> <20060627222234.GP29199@elf.ucw.cz> <m2k66qzgri.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2k66qzgri.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  Pavel> I do not think suspend2 works on more machines than in-kernel
>  Pavel> swsusp. Problems are in drivers, and drivers are shared.
> 
>  Pavel> That means that if you have machine where suspend2 works and
>  Pavel> swsusp does not, please tell me. I do not think there are many
>  Pavel> of them.
> 
> Accept the facts -- for some reason, there is a fairly large user base
> that goes to all the bother of using suspend2, which requires
...
> That is a fact, and all the hand waving won't change it.

Users like suspend2 eye candy => swsusp must be unreliable?

I know users that installed swsusp, decided they want progress bars,
and went for suspend2.

> I'm tired of this. It's taking years for Linux to get reasonably working
> suspend facilities, which is a shame. In my opinion a large part of the
> problem is you opposing Nigel's patches. Problem is, for many people
> Nigel's code works while yours does not.

Nigel only submitted his code once, month or so ago, as series of 200
or so patches. Do not blame me for _that_.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
