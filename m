Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWAANZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWAANZK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 08:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWAANZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 08:25:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46811 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751345AbWAANZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 08:25:09 -0500
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
From: Arjan van de Ven <arjan@infradead.org>
To: Bradley Reed <bradreed1@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060101131615.GT3811@stusta.de>
References: <20051231202933.4f48acab@galactus.example.org>
	 <1136106861.17830.6.camel@laptopd505.fenrus.org>
	 <20060101115121.034e6bb7@galactus.example.org>
	 <20060101115038.GR3811@stusta.de>
	 <20060101145402.0c6292bb@galactus.example.org>
	 <20060101131615.GT3811@stusta.de>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 14:25:05 +0100
Message-Id: <1136121906.17830.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jan 01, 2006 at 02:54:02PM +0200, Bradley Reed wrote:
> > On Sun, 1 Jan 2006 12:50:38 +0100
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > MPlayer has more than enough output drivers including some that work 
> > > without the nvidia module.
> > > 
> > > If your problem was an RTC one, it might have even trigger using the 
> > > AAlib output driver.
> > 
> > True, I can reproduce this kernel bug by running mplayer with AAlib
> > output without nvidia's module loaded. I never run mplayer under usual
> > use with the aalib library and never thought to test with it. If I had
> > been asked to try that, I would have.
> > 
>  Yes, I understand that GPL fanatics like Arjan refuse to look at bugs
>  from tainted kernels, regardless of whether the tainted kernel module
>  is at fault. That is his right. So be it. 
> ...

I wonder what made you describe me as a fanatic based on my posting? My
posting was not about license at all, it was about the non-debugability
and the wasting of time (compared to spending time on bugs where the
developer does have a chance). Maybe you're one of those nvidia fanatics
who wants to demand that all kernel developers spent all their time on
your toy without you having to pay anything, even if it's not a useful
way for these people to spend their time in general. 
(see how easy it is to name someone a fanatic? :)


