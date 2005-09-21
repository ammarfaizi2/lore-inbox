Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVIUIba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVIUIba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 04:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVIUIb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 04:31:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11172 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750776AbVIUIb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 04:31:29 -0400
Date: Wed, 21 Sep 2005 09:31:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jayakumar.alsa@gmail.com, perex@suse.cz, mj@ucw.cz,
       alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13.1 1/1] CS5535 AUDIO ALSA driver
Message-ID: <20050921083109.GA27254@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, jayakumar.alsa@gmail.com,
	perex@suse.cz, mj@ucw.cz, alsa-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <200509190639.j8J6dIM4007948@localhost.localdomain> <20050920152830.7ef6733b.akpm@osdl.org> <47f5dce305092017031a2ba375@mail.gmail.com> <20050920172309.626db866.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920172309.626db866.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 05:23:09PM -0700, Andrew Morton wrote:
> > I'm not sure what to do. I'd be happy to take them out. But I woudn't
> > mind leaving them in if that's what alsa convention is.
> 
> I'd be inclined to stick with the alsa style.  That's just an fyi if you
> plan on working in other places.

I'd _really_ prefer to fix all of alsa.  Alsa is so full of wrappers
and multiple names for the same thing that's it's almost impossibly
for a normal kernel developer to fix anythign in there.

