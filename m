Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269905AbUIDLa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269905AbUIDLa7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269909AbUIDL1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:27:41 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:11014 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269901AbUIDLUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:20:55 -0400
Date: Sat, 4 Sep 2004 12:20:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904122044.A14310@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904120352.B14037@infradead.org> <4139A480.4060306@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4139A480.4060306@tungstengraphics.com>; from keith@tungstengraphics.com on Sat, Sep 04, 2004 at 12:18:24PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 12:18:24PM +0100, Keith Whitwell wrote:
> You didn't stick with that long Christoph.  We're not even past first base 
> yet.  Let's try again?
> 
> So, I've got this file "patch-2.6.8.1.bz2".  Lets suppose my older brother 
> comes in & compiles it up for me & I'm now running 2.6.8.1 - it's implausible 
> I know, but let's make it easier for you.  Now, why isn't my i915 working?

Because the drm developer took a long time to submit the driver after
is was finished as they develop in a separate CVS tree instead of the kernel
tree.

