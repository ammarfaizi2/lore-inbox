Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVBZQrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVBZQrg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 11:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVBZQrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 11:47:36 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:59054 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261232AbVBZQrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 11:47:24 -0500
Date: Sat, 26 Feb 2005 08:46:56 -0800
To: Stelian Pop <stelian@popies.net>,
       Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
       Wayne Scott <wscott@bitmover.com>
Subject: Re: BKCVS still updated?
Message-ID: <20050226164656.GA11919@bitmover.com>
Mail-Followup-To: lm@bitmover.com, Stelian Pop <stelian@popies.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, Wayne Scott <wscott@bitmover.com>
References: <tnxekf71drd.fsf@arm.com> <20050225095837.GA17559@sd291.sivit.org> <20050225180218.GA7347@bitmover.com> <20050226114952.GA18749@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226114952.GA18749@deep-space-9.dsnet>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 12:49:53PM +0100, Stelian Pop wrote:
> On Fri, Feb 25, 2005 at 10:02:18AM -0800, Larry McVoy wrote:
> 
> > > He should be back now, maybe he can tell us more about what happened ?
> > 
> > We had a nameserver problem and the machine dedicated to this didn't get
> > updated with a new resolve.conf.  It's fixed now and updating, probably
> > be there in an hour.
> 
> I confirm it works again, thanks.
> 
> While you're at it, could you please increase the rate of update,
> as we discussed a few weeks ago ? 

Yes but I want to think about it a bit, I need to go relearn how it
picks the changesets it exports 1:1 to CVS commits vs the csets that
get collapsed into the merge nodes.  I'm worried that more frequent
exports may result yield suboptimal results.  If that's not true then
we'll export it every few hours or every time bkbits.net gets updated.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
