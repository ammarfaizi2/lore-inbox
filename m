Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVC2XID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVC2XID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVC2XID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:08:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:18326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261625AbVC2XH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:07:57 -0500
Date: Tue, 29 Mar 2005 15:04:36 -0800
From: Chris Wright <chrisw@osdl.org>
To: "L. A. Walsh" <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RFC: 2.6.release.patchlevel:  Patch against 2.6.release[.0] ?
Message-ID: <20050329230436.GQ28536@shell0.pdx.osdl.net>
References: <4249DC03.4000806@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4249DC03.4000806@tlinx.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* L. A. Walsh (lkml@tlinx.org) wrote:
> Given the frequency with which stabilization patches may be released, it
> may not be practical to expect users to catch each release announcement
> and download each patch.
> 
> Especially if small patches are released for stability, as one might
> (hopefully) expect.  Assuming that stability and "fix-it" patches will
> generally be small (I'd hope).  Seeing that the latest "fix-it" patch
> is already at ".6", I'd have to load multiple patches to catch up from
> 2.6.11.  I blinked my eyes and missed a few or 5 previous stability
> patches, so I just downloaded the entire bzip...not a biggie, but
> might create less load on servers if I didn't need to go through 6
> patch applications to get current.

The patches on kernel.org in v2.6/ are already against the base (i.e.
patch-2.6.11.6.bz2 is against 2.6.11).  The patches in v2.6/incr/
are incremental between -stable releases (i.e. patch-2.6.11.5-6.bz2 is
against 2.6.11.5).

thanks,
-chris
