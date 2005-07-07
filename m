Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVGGSDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVGGSDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVGGSDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:03:46 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:19624 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S261321AbVGGSDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:03:41 -0400
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re:
	[ltp] IBM HDAPS Someone interested? (Accelerometer))
From: Dave Hansen <dave@sr71.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jens Axboe <axboe@suse.de>, Clemens Koller <clemens.koller@anagramm.de>,
       Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <1120759299.30980.12.camel@mindpipe>
References: <42C8C978.4030409@linuxwireless.org>
	 <20050704063741.GC1444@suse.de>
	 <1120461401.3174.10.camel@laptopd505.fenrus.org>
	 <20050704072231.GG1444@suse.de>
	 <1120462037.3174.25.camel@laptopd505.fenrus.org>
	 <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com>
	 <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de>
	 <42CD600C.2000105@anagramm.de>  <20050707172707.GI24401@suse.de>
	 <1120757900.5829.38.camel@localhost>  <1120759299.30980.12.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 11:03:36 -0700
Message-Id: <1120759416.5829.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 14:01 -0400, Lee Revell wrote:
> On Thu, 2005-07-07 at 10:38 -0700, Dave Hansen wrote:
> > On Thu, 2005-07-07 at 19:27 +0200, Jens Axboe wrote:
> > > This _is_ the generic way, if your drive doesn't support it you are out
> > > of luck.
> > 
> > I do wonder what is done in Windows, though...
> 
> My guess would be that it silently upgrades the firmware if it detects
> that head parking isn't supported.

More likely that the things were shipped with firmware that only knows
some proprietary method of doing that we don't know about.

-- Dave

