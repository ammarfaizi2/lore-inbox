Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbVHKNv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbVHKNv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 09:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVHKNv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 09:51:29 -0400
Received: from verein.lst.de ([213.95.11.210]:11733 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1030306AbVHKNv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 09:51:28 -0400
Date: Thu, 11 Aug 2005 15:51:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050811135114.GA6568@lst.de>
References: <20050810080057.GA5295@lst.de> <Pine.LNX.4.61.0508111226530.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508111226530.3743@scrub.home>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 12:44:34PM +0200, Roman Zippel wrote:
> No objection really, but I recently reformatted the m68k sys_ptrace() so 
> it would be easier to regenerate your changes on top of this. I can do 
> this for you if we can agree on to merge at least the m68k ptrace changes 
> before this.
> For reference I put the patches at www.xs4all.nl/~zippel/m68k_merge/
> (tf, p_ws, p_c are the relevant patches).

I'll leave m68k out of the patchset for now.  If you have your patches
done when I'm doing the next round of changes in I'll do it atop of
those, else you'll have to redo your changes, bad luck for not syncing
up with mainline.

