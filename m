Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWAWEwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWAWEwR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 23:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWAWEwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 23:52:17 -0500
Received: from cantor.suse.de ([195.135.220.2]:52428 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751394AbWAWEwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 23:52:17 -0500
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Fixing make mandocs
Date: Mon, 23 Jan 2006 05:52:08 +0100
User-Agent: KMail/1.8.2
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
References: <200601230531.27609.ak@suse.de> <20060122204921.613349e5.rdunlap@xenotime.net>
In-Reply-To: <20060122204921.613349e5.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601230552.09142.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 05:49, Randy.Dunlap wrote:
> On Mon, 23 Jan 2006 05:31:27 +0100 Andi Kleen wrote:
> 
> > 
> > Here would be a good janitor task for 2.6.16. make mandocs currently
> > doesn't build because a number of descriptions are missing parameters etc.
> > It would be good if someone could fix that and submit patches for 2.6.16.
> > 
> > It should be relatively straight forward, if one cannot figure out
> > what a missing parameter does adding a dummy description ("Undocumented") 
> > would be also ok.
> > 
> > -Andi
> 
> Lots of these have been fixed in the last 2-3 days by Martin Waitz
> and/or me and have been posted on lkml.  Martin is collecting them
> in his kernel-doc tree.

Ok good. Are they going into 2.6.16?

-Andi
