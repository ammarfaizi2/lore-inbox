Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVCHFua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVCHFua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVCHFu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:50:29 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:18328 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261535AbVCHFuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:50:11 -0500
Date: Tue, 8 Mar 2005 05:50:07 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] (#2) radeonfb: PLL access workaround
In-Reply-To: <1110254093.13607.244.camel@gaston>
Message-ID: <Pine.LNX.4.58.0503080547260.23424@skynet>
References: <1110243597.13594.224.camel@gaston> <1110254093.13607.244.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > Please test and let me know if it works. If it's fine, then it should go
> > to -mm, and eventually after a while, to a 2.6.11.x update.
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


I've tested this on my M7 chips which hung on boot with radeonfb but no
fbcon on 2.6.11, and it works fine, if things need a vote for 2.6.11.x
after its been in -mm for a while I'll vote for it :-)

Dave.
