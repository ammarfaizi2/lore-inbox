Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTIMRRg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbTIMRRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:17:36 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:13211 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261921AbTIMRRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:17:34 -0400
Subject: Re: People, not GPL  [was: Re: Driver Model]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1063444117.7962.19.camel@rousalka.dyndns.org>
References: <1063444117.7962.19.camel@rousalka.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063473375.8702.12.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sat, 13 Sep 2003 18:16:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 10:08, Nicolas Mailhot wrote:
> At some point Linus decreeted linking closed modules was ok with him
> (note this was done without consulting anyone, so others contributors
> could have objected - they did choose to release stuff under the gpl
> after all - but this being Linus they let it pass)

Other contributors objected at the time. Furthermore there is merging of
third party GPL code from bodies like the FSF who also object and didnt
submit their code themselves. 

> will be sued (people that link to symbols not GPL-ONLY could be sued too
> but everyone seems to have agreed to let it pass). Removing the software

No. Sorry its neccessary to keep correcting people here but I have no
intention of allowing anyone creating a derivative work to claim
estoppel when they get their arses kicked some years on. Their sole
defence is that the work is not derivative. In some cases I can believe
that could be a valid claim.

As to _GPL. Its primarily a way of ensuring people who mix binary code
in with their kernel in unsupportable ways are made aware of it, and so
we can all use filter rules to discard their bugs.

Some vendors do support certain third party binary modules in some
specific enterprise configurations, others don't. In the community case
the general rule is we don't.

Alan

