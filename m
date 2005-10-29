Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbVJ2ASs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVJ2ASs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVJ2ASs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:18:48 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:32876 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750899AbVJ2ASr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:18:47 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git pull] InfiniBand updates for 2.6.14
X-Message-Flag: Warning: May contain useful information
References: <523bmlqkg0.fsf@cisco.com> <20051028171218.2b8e71e7.akpm@osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 28 Oct 2005 17:18:42 -0700
In-Reply-To: <20051028171218.2b8e71e7.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 28 Oct 2005 17:12:18 -0700")
Message-ID: <52y84dp44d.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 29 Oct 2005 00:18:43.0683 (UTC) FILETIME=[523DAB30:01C5DC1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> a) arrange for the current infiniband devel tree to be
    Andrew> included in -mm and

Sure.  How do you want to handle that?  The way I've been working
lately is to merge things onto my "upstream" branch when I intend for
them to go to Linus eventually, and merge that onto the "for-linus"
branch when I'm going to ask Linus to pull.  I guess it would make
sense for you to grab the upstream branch for -mm.

    Andrew> b) arrange for infiniband patches to get wider review than this?

No objection from me.  How do you suggest I do that?  Post things to
linux-kernel as I merge them into git?

Thanks,
  Roland
