Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUIDWXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUIDWXI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 18:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUIDWXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 18:23:08 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:29446 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263795AbUIDWXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 18:23:06 -0400
Date: Sat, 4 Sep 2004 23:21:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904232154.A18493@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>,
	Arjan van de Ven <arjanv@redhat.com>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Dave Jones <davej@redhat.com>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com> <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com> <4139B03A.6040706@tungstengraphics.com> <Pine.LNX.4.58.0409041311020.25475@skynet> <1094301014.2801.10.camel@laptop.fenrus.com> <Pine.LNX.4.58.0409041333230.25475@skynet> <Pine.LNX.4.58.0409042311270.24528@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409042311270.24528@skynet>; from airlied@linux.ie on Sat, Sep 04, 2004 at 11:17:40PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 11:17:40PM +0100, Dave Airlie wrote:
> 
> Actually after sleeping on this, I've just realised technically whether
> the code is in a core separate module or driver module is only going to
> affect maybe 5% of the work and the Makefiles/Kconfig at the end, so
> following the principles of a)least surprise, b) kernel must remain
> stable, I think I can proceed with moving stuff into libraries and the
> likes without making the final decision until later, we will probably
> start with having the library type code in the driver (where it is now)
> and make it possible to change later, as it evolves..

Fine with me.  ad keep up your good work.
