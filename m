Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263261AbUCNCcl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 21:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUCNCcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 21:32:41 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:9747 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263257AbUCNCbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 21:31:45 -0500
Date: Sun, 14 Mar 2004 10:33:00 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Miklos Szeredi <mszeredi@inf.bme.hu>
cc: hallyn@CS.WM.EDU, linux-kernel@vger.kernel.org
Subject: Re: unionfs
In-Reply-To: <200403111544.i2BFi7O06675@kempelen.iit.bme.hu>
Message-ID: <Pine.LNX.4.58.0403141032230.4585@raven.themaw.net>
References: <200403080952.i289qsU12658@kempelen.iit.bme.hu>
 <20040311151343.GA943@escher.cs.wm.edu> <200403111544.i2BFi7O06675@kempelen.iit.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Miklos Szeredi wrote:

> 
> I'll have to, as this is needed for AVFS.  Not unionfs, but something
> similar, that allows file/directory lookups for special filenames to
> be redirected to another filesystem.

I have a need for this in autofs4 also.

Ian

