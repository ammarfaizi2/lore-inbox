Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269898AbUIDLtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269898AbUIDLtR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269883AbUIDLtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:49:11 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:15110 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269898AbUIDLrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:47:17 -0400
Date: Sat, 4 Sep 2004 12:46:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904124658.A14628@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Dave Jones <davej@redhat.com>, Dave Airlie <airlied@linux.ie>,
	Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com> <4139A9F4.4040702@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4139A9F4.4040702@tungstengraphics.com>; from keith@tungstengraphics.com on Sat, Sep 04, 2004 at 12:41:40PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 12:41:40PM +0100, Keith Whitwell wrote:
> Please don't think that I'm talking for Tungsten at this or any other time on 
> the DRI list.  I'm talking for myself and have never attempted to convey here 
> or elsewhere a "company" view without explictly flagging it up as such. 
> Apologies if the use of a TG mailing address is confusing, but I will have to 
> continue using it for the meantime as it is the one subscribed to this list.

Even if you are not speaking for Thungesten you pretty much show that
Thungsten has developers that in an area that overlaps with their works are
not willing to get things done the kernel way.

This should be a v ery big warnings sign for potentitial Thungsten Customers
to look for a better supplier or at least give very strong directions.

> Likewise, are you making a RedHat statement that you believe that your 
> endusers need to be able to compile a kernel to use your products, or is that 
> a statement of a regular LK developer?  I'm sure you appreciate the parallel.

That's not what he said.  But sees Dave's next mail.

> But in general, yes, I'd like to think that you don't have to have even heard 
> of a compiler in order to be able to install a video driver...

And how does taking random dri snapshots help you there?  The only sane way
to make that happen is to make sure it's in the various distro kernels ASAP.

