Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754798AbWKITWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbWKITWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832AbWKITWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:22:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26085 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754798AbWKITWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:22:03 -0500
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20061109111212.eee33367.akpm@osdl.org>
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>
	 <1163024531.3138.406.camel@laptopd505.fenrus.org>
	 <20061108145150.80ceebf4.akpm@osdl.org>
	 <1163064401.3138.472.camel@laptopd505.fenrus.org>
	 <20061109013645.7bef848d.akpm@osdl.org>
	 <1163065920.3138.486.camel@laptopd505.fenrus.org>
	 <20061109111212.eee33367.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 09 Nov 2006 20:21:55 +0100
Message-Id: <1163100115.3138.524.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 11:12 -0800, Andrew Morton wrote:
> On Thu, 09 Nov 2006 10:52:00 +0100
> Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > Do you have the
> > impression that high quality bug reports on lkml (with this I mean ones
> > where there is sufficient information, which are not a request for
> > support and where the reporter actually answers questions that are asked
> > him) are not getting reasonable attention? 
> 
> Yes.
> 
> And why does the report quality matter?  

because it matters where people spend their time. And if you count
bugreports that are actually distro support questions and then say "but
these aren't looked at" it's not fair either.

> If there's insufficient info you
> just ask for more.

and that does happen. And half the time people just remain silent :(
I know I look at a whole bunch of bugreports in areas that I work on. I
see a lot of other people doing something similar. That doesn't mean
nothing slips through. I'm sure stuff does slip through. I would HOPE
it's really obscure things only; but I fear it's also cases where the
reporter didn't put the right people on the CC as well ;(


> But we all know that and nothing's going to happen so there's really not
> much point in discussing it.  I have 270 saved-up-lkml-bug-reports to
> process.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

