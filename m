Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267606AbUHPMZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267606AbUHPMZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUHPMZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:25:20 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:15819 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267606AbUHPMYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:24:37 -0400
Date: Mon, 16 Aug 2004 13:24:30 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20040816132022.A10567@infradead.org>
Message-ID: <Pine.LNX.4.58.0408161323300.32584@skynet>
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org>
 <Pine.LNX.4.58.0408160038320.9944@skynet> <20040816101732.A9150@infradead.org>
 <Pine.LNX.4.58.0408161019040.21177@skynet> <20040816105014.A9367@infradead.org>
 <1092654719.20523.18.camel@localhost.localdomain> <20040816132022.A10567@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Works fine on all my pmacs here.  In fact X works only on fbdev for
> full features.

I think Alan would classify that as luck rathar than design... and I would
tend to agree, does it work if you load the driver modules in any order?
or do you always to fb then drm? or the other way around?

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

