Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVDCAm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVDCAm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 19:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVDCAm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 19:42:57 -0500
Received: from mail.dif.dk ([193.138.115.101]:52901 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261403AbVDCAm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 19:42:56 -0500
Date: Sun, 3 Apr 2005 02:45:14 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Joseph E. Sacco, Ph.D." <joseph_sacco@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: prepatch 2.6.12-rc1 does not apply cleanly to linux-2.6.11.6
In-Reply-To: <1112488705.24524.21.camel@plantain.jesacco.com>
Message-ID: <Pine.LNX.4.62.0504030244090.2525@dragon.hyggekrogen.localhost>
References: <1112488705.24524.21.camel@plantain.jesacco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Apr 2005, Joseph E. Sacco, Ph.D. wrote:

> prepatch 2.6.12-rc1 [2005-03-18 02:52 UTC] does not apply cleanly to
> linux-2.6.11.6:
> 
No, it does not, it applies to the base 2.6.11, *not* to 2.6.11.6 - first 
back out the 2.6.11.6 patch, then apply the 2.6.12-rc1 patch.

-- 
Jesper Juhl


