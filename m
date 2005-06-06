Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVFFWLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVFFWLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVFFWLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:11:15 -0400
Received: from cpe-24-93-172-51.neo.res.rr.com ([24.93.172.51]:35969 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261269AbVFFWKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:10:41 -0400
Date: Mon, 6 Jun 2005 18:06:13 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
Message-ID: <20050606220612.GB3289@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <42A0D88E.7070406@pobox.com> <20050603163843.1cf5045d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603163843.1cf5045d.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 04:38:43PM -0700, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > 
> > So...  are we gonna see 2.6.12 sometime soon?
> > 
> 
> Current plan is -rc6 in a few days, 2.6.12 a week after that.
> 
> 
> My things-to-worry-about folder still has 244 entries.  Nobody seems to
> care much.  Poor me.
> 
> Lots of USB problems, quite a few input problems.  fbdev, ACPI, ATAPI.  All
> the usual suspects.


> Subject: Re: Fw: [Bugme-new] [Bug 4561] New: isapnp fails to find/init es18xx sound card

This is more of a feature request than a bug, as in we don't currently have
a PnPBIOS driver for this hardware.  I need to look at the es18xx code to
see how difficult it will be.

> Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?

I'm looking into this issue now.

> Subject: Re: [linux-pm] potential pitfall? changing configuration while PC in hibernate (fwd)

I think we're gradually improving this.  Suspend-to-ram is also an issue.

Thanks,
Adam
