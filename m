Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVAUGLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVAUGLd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVAUGLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:11:32 -0500
Received: from mail.suse.de ([195.135.220.2]:51911 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262278AbVAUGLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:11:24 -0500
Date: Fri, 21 Jan 2005 07:11:19 +0100
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andi Kleen <ak@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, tiwai@suse.de,
       mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] compat ioctl security hook fixup
Message-ID: <20050121061119.GA657@wotan.suse.de>
References: <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com> <20050112214326.GB14703@wotan.suse.de> <20050112225230.GA14590@kroah.com> <20050112151049.7473db7d.akpm@osdl.org> <20050119213818.55b14bb0.akpm@osdl.org> <20050121000935.GA341@mellanox.co.il> <20050120172656.R24171@build.pdx.osdl.net> <20050121041959.GA27155@wotan.suse.de> <20050120215103.S24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120215103.S24171@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 09:51:03PM -0800, Chris Wright wrote:
> > If you add it make at least sure it's not EXPORT_SYMBOL()ed.
> 
> It's certainly not, nor intended to be.  Would a comment to that
> affect alleviate your concern?

Yes please.

-Andi
