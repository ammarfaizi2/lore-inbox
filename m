Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbWI0SBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbWI0SBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 14:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbWI0SBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 14:01:47 -0400
Received: from THUNK.ORG ([69.25.196.29]:50100 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030514AbWI0SBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 14:01:46 -0400
Date: Wed, 27 Sep 2006 14:01:29 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
Message-ID: <20060927180129.GA7469@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Sergey Panov <sipan@sipan.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <1159319508.16507.15.camel@sipan.sipan.org> <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr> <1159342569.2653.30.camel@sipan.sipan.org> <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 10:58:41AM +0200, Jan Engelhardt wrote:
> >... ???. I am not so sure. Kernel is really a small thing. The VMWare
> >proprietary hyper-visor was/is reusing Linux drivers with ease, why BSD or
> >Hurd can not do the same? As a former (Linux) driver writer I like to show the
> >following numbers to my friends:
> 
> Oh well I was rather interpreting the question as "What about Hurd?" and 
> my answer was the same from the Hurd page last time I read it.
> "It's not so complete to make up a production system." or similar.

Well, that will be very simple.  If the Hurd gets relicensed to be
GPLv3, it won't be able to use Linux kernel device drivers any more,
because they will be GPLv2, and the GPLv2 and GPLv3 licenses are
incompatible.  But that's the FSF's problem, not ours...

						- Ted

