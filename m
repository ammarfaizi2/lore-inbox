Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSFEUub>; Wed, 5 Jun 2002 16:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316422AbSFEUua>; Wed, 5 Jun 2002 16:50:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18952 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316408AbSFEUu3>; Wed, 5 Jun 2002 16:50:29 -0400
Date: Wed, 5 Jun 2002 22:50:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 swsusp: stop abusing headers with non-inlined functions
Message-ID: <20020605205033.GC15105@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020605122714.GA4376@elf.ucw.cz> <Pine.LNX.4.33.0206051330370.1471-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hmm.. Which version of the kernel is this against? It doesn't apply to 
> clean 2.5.20 (which doesn't even have suspend.c), nor does it apply to my 
> current BK head with your previous patches installed.
> 
> Or does your mailer corrupt whitespace or something?
> 
> The difference seems to be one empty line. I applied it by hand, but
> I

Sorry, the problem was probably between keyboard and chair
(i.e. me). I should really get your BK tree exported to CVS
somewhere...
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
