Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269909AbUIDLbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269909AbUIDLbA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269901AbUIDL16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:27:58 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:12294 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267683AbUIDL1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:27:06 -0400
Date: Sat, 4 Sep 2004 12:26:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Keith Whitwell <keith@tungstengraphics.com>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904122655.A14407@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904120352.B14037@infradead.org> <Pine.LNX.4.58.0409041207060.25475@skynet> <20040904121355.E14123@infradead.org> <Pine.LNX.4.58.0409041221580.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409041221580.25475@skynet>; from airlied@linux.ie on Sat, Sep 04, 2004 at 12:24:32PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 12:24:32PM +0100, Dave Airlie wrote:
> >
> > A user without a clue should better be using a supported distribution.
> > If he used Fedora Core2 instead of the totally outdated and unsupported
> > RH9 he'd already have a kernel with i915 support on his disk.
> 
> What about Debian? they would have a 2.4 kernel.. is Debian not supported,
> no-one told me...

Due to the policies of the release manager Debian stable is a totalally lost
cause.  It's missing all other support bits for i915 plattforms aswell.

