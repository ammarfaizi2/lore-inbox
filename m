Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWDQWFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWDQWFW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWDQWFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:05:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37762 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751337AbWDQWFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:05:21 -0400
Date: Mon, 17 Apr 2006 23:05:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>,
       Paul Mundt <lethal@linux-sh.org>,
       Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [linuxsh-dev] [PATCH] ALSA driver for Yamaa AICA on Sega Dreamcast
Message-ID: <20060417220512.GA16119@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>,
	Adrian McMenamin <adrian@mcmen.demon.co.uk>,
	Paul Mundt <lethal@linux-sh.org>,
	Alsa-devel <alsa-devel@lists.sourceforge.net>,
	linux-sh <linuxsh-dev@lists.sourceforge.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <1145232784.12804.2.camel@localhost.localdomain> <20060417012913.GA16821@linux-sh.org> <1145304037.9244.27.camel@localhost.localdomain> <1145310435.16138.83.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145310435.16138.83.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 05:47:15PM -0400, Lee Revell wrote:
> On Mon, 2006-04-17 at 21:00 +0100, Adrian McMenamin wrote:
> > But I am happy to change it.
> > 
> > 
> 
> Please don't - when adding code to a subsystem with different
> conventions than mainline the FAQ says to follow the subsystem
> conventions.

Nope.  Alsa needs to gradually converted from something that looks like
cat puke to normal kernel style.  Every new driver that's written properly
helps.
