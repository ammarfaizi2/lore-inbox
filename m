Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVGCKlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVGCKlF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 06:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVGCKlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 06:41:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2503 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261251AbVGCKlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 06:41:02 -0400
Date: Thu, 30 Jun 2005 18:30:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: FUSE merging?
Message-ID: <20050630163045.GA1299@elf.ucw.cz>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw6N-0000V9-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dnw6N-0000V9-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > if you are so interested in getting fuse merged... why not merge it
> > first with the security stuff removed entirely. And then start
> > discussing putting security stuff back in ?
> 
> BTW, I can split out the security stuff into a separate patch from the
> rest, if people feel more confortable discussing a concrete patch,
> instead of a range of lines (actually a 15 line function) of the
> whole.

Yes, I think that would help. [And also make it last in the series
;-)]
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
