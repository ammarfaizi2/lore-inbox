Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbUK2Wnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUK2Wnc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUK2Wfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:35:30 -0500
Received: from gprs214-92.eurotel.cz ([160.218.214.92]:63625 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261850AbUK2We6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:34:58 -0500
Date: Mon, 29 Nov 2004 23:34:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Stefan Seyfried <seife@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041129223437.GD3867@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams> <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <41AAED32.2010703@suse.de> <1101766833.4343.425.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101766833.4343.425.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >>>:> But not everyone who uses 2.6.9 uses swsusp. :>
> > 
> > and not everyone who downloads suspend2 uses it ;-)
> 
> Yes... I'd say the relative percentage would be much higher, though.

Agreed.

> > > change a parameter or forcing them to do an ls in /dev with obscure
> > > parameters (to get the major and minor numbers) when they already know
> > > they want /dev/sda1 isn't user friendly. Obviously user friendliness is 
> > 
> > This can easily be done by a userspace helper. You do use the
> > (userspace) X server to display your GUI, don't you?
> 
> No. Not at all. All of userspace is well and truly wedged in a block of
> ice by then.

I think that was not what Stefan wanted to say.

> Regarding acceptance, there's no point in getting it accepted into the
> kernel if we end up with something that's user-unfriendly. I think it
> will help a lot if we agree that suspend does need to blur the lines
> between kernel and userspace a little, in the interests of providing
> software that is superior.

I guess we'll have to agree to disagree here. I do not think suspend
is special enough to blur the lines...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
