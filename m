Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUKCPnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUKCPnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUKCPnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:43:45 -0500
Received: from cantor.suse.de ([195.135.220.2]:29414 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261638AbUKCPlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:41:37 -0500
Date: Wed, 3 Nov 2004 16:32:54 +0100
From: Andi Kleen <ak@suse.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: ak@suse.de, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: dmi_scan on x86_64
Message-ID: <20041103153254.GF24195@wotan.suse.de>
References: <20041103144006.GE24195@wotan.suse.de> <wPc3Mf1E.1099495179.6511660.khali@gcu.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wPc3Mf1E.1099495179.6511660.khali@gcu.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 04:19:39PM +0100, Jean Delvare wrote:
> 
> > > Any reason why dmi_scan is availble on the i386 arch and not on the
> > > x86_64 arch? I would have a need for the latter (for run-time
> > > identification purposes, not boot-time blacklisting).
> >
> > Here's a patch for testing.
> 
> Thanks Andi. Unfortunately, I don't own an x86_64 system myself, so I

Ok. I won't push the patch then when it isn't really needed.

-Andi
