Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWDQWQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWDQWQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWDQWQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:16:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3017 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751300AbWDQWQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:16:00 -0400
Subject: Re: [Alsa-devel] Re: [linuxsh-dev] [PATCH] ALSA driver for Yamaa
	AICA on Sega Dreamcast
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>,
       Paul Mundt <lethal@linux-sh.org>,
       Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060417220512.GA16119@infradead.org>
References: <1145232784.12804.2.camel@localhost.localdomain>
	 <20060417012913.GA16821@linux-sh.org>
	 <1145304037.9244.27.camel@localhost.localdomain>
	 <1145310435.16138.83.camel@mindpipe> <20060417220512.GA16119@infradead.org>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 18:15:56 -0400
Message-Id: <1145312157.16138.87.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 23:05 +0100, Christoph Hellwig wrote:
> On Mon, Apr 17, 2006 at 05:47:15PM -0400, Lee Revell wrote:
> > On Mon, 2006-04-17 at 21:00 +0100, Adrian McMenamin wrote:
> > > But I am happy to change it.
> > > 
> > > 
> > 
> > Please don't - when adding code to a subsystem with different
> > conventions than mainline the FAQ says to follow the subsystem
> > conventions.
> 
> Nope.  Alsa needs to gradually converted from something that looks like
> cat puke to normal kernel style.  Every new driver that's written properly
> helps.

OK thanks.  I was certain I saw this in the FAQ at some point but now I
can't find it.

Lee

