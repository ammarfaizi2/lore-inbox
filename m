Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUHGOsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUHGOsV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 10:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUHGOsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 10:48:20 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:60172 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262905AbUHGOsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 10:48:17 -0400
Date: Sat, 7 Aug 2004 15:48:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jon Smirl <jonsmirl@yahoo.com>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: DRM function pointer work..
Message-ID: <20040807154808.D18510@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@yahoo.com>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
	DRI developer's list <dri-devel@lists.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>
References: <20040806171641.14189.qmail@web14928.mail.yahoo.com> <1091885466.18408.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1091885466.18408.13.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Sat, Aug 07, 2004 at 02:31:07PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 02:31:07PM +0100, Alan Cox wrote:
> And thats one of the big reasons its such a mess and doesn't work out.
> Nobody is testing or reviewing it until some huge "merge point" occurs
> at which point you run the risk of people saying "Actually your design
> sucks", or in the 2.6 case finding out too late so that there is a patch
> kit to upgrade your 2.6 to the 2.4 console driver

Sorry, but the reason for the fbdev mess is that James is completely unable
to do proper project managment.  The model works fine for every other kernel
subsystem.
