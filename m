Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUBEArB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUBEAqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:46:12 -0500
Received: from gprs148-146.eurotel.cz ([160.218.148.146]:28033 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265139AbUBEAkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:40:35 -0500
Date: Thu, 5 Feb 2004 01:39:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "La Monte H.P. Yarroll" <piggy@timesys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040205003944.GB8768@elf.ucw.cz>
References: <20040204230133.GA8702@elf.ucw.cz> <20040204152137.500e8319.akpm@osdl.org> <402182B8.7030900@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402182B8.7030900@timesys.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I wouldn't support inclusion of i386 kgdb until it has had a lot of
> >cleanup, possible de-featuritisification and some thought has been applied
> >to splitting it into arch and generic bits.  It's quite a lot of work.
> 
> Amit has started at least the third activity--he has split much of kgdb
> into arch and generic bits.
> 
> Could you elaborate a little on the first two?
> 
> What major kinds of cleanup are we talking about?  Style issues?
> 
> What features (or classes of features) do you find excessive?  Would
> it be sufficient to add a few config items to control subfeatures
> of kgdb?
> 
> These are not idle questions.  If the amount of work to get it ready
> for acceptance is tractable, I know a company that may be willing to
> pay to have the work done.

Well, I guess I know two more such companies. Seems like everyone and
their aunt want kgdb these days :-).
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
