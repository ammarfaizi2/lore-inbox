Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbUCDKSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 05:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUCDKSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 05:18:53 -0500
Received: from tartutest.cyber.ee ([193.40.6.70]:36101 "EHLO
	tartutest.cyber.ee") by vger.kernel.org with ESMTP id S261796AbUCDKSx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 05:18:53 -0500
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org, eger@havoc.gtf.org
Subject: Re: [PATCH] UTF-8ifying the kernel source
In-Reply-To: <20040304100503.GA13970@havoc.gtf.org>
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.3 (i686))
Message-Id: <E1Aypx5-0000mb-5u@rhn.tartu-labor>
Date: Thu, 04 Mar 2004 12:19:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DE> Here you find the first of several patches to convert the kernel
DE> source from ISO Latin-1 to UTF-8.  I'm working on the files that didn't
DE> auto-convert easily; comments welcome ;-)

Why? It's just easier to use plain 8-bit text files today (with editors,
code tools etc) and accept the limitations of it that to overcome the
limitations by forcing people to UTF-8 editors & other tools.

I am not a kernel developer but this seems a bad idea to me.

-- 
Meelis Roos
