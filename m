Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVGGRnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVGGRnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVGGRlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:41:13 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:22420 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S261321AbVGGRib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:38:31 -0400
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re:
	[ltp] IBM HDAPS Someone interested? (Accelerometer))
From: Dave Hansen <dave@sr71.net>
To: Jens Axboe <axboe@suse.de>
Cc: Clemens Koller <clemens.koller@anagramm.de>,
       Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050707172707.GI24401@suse.de>
References: <42C8C978.4030409@linuxwireless.org>
	 <20050704063741.GC1444@suse.de>
	 <1120461401.3174.10.camel@laptopd505.fenrus.org>
	 <20050704072231.GG1444@suse.de>
	 <1120462037.3174.25.camel@laptopd505.fenrus.org>
	 <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com>
	 <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de>
	 <42CD600C.2000105@anagramm.de>  <20050707172707.GI24401@suse.de>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 10:38:20 -0700
Message-Id: <1120757900.5829.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 19:27 +0200, Jens Axboe wrote:
> On Thu, Jul 07 2005, Clemens Koller wrote:
> > Well, sure, it's not a notebook HDD, but maybe it's possible
> > to give headpark a more generic way to get the heads parked?
> 
> This _is_ the generic way, if your drive doesn't support it you are out
> of luck.

I do wonder what is done in Windows, though...

They had to have had a method to park the drive there, or they probably
wouldn't have even included the HDAPS driver in the first place.
Anybody wanna strace the Windows app?

-- Dave

