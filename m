Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbTDNNeg (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263261AbTDNNef (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:34:35 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:31404 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263207AbTDNNed (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 09:34:33 -0400
Date: Mon, 14 Apr 2003 15:46:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: James Bourne <jbourne@hardrock.org>
Cc: Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops: ptrace fix buggy
Message-ID: <20030414134603.GB10347@wohnheim.fh-wedel.de>
References: <200304121154.32997.m.c.p@wolk-project.de> <Pine.LNX.4.44.0304140713510.22450-100000@cafe.hardrock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0304140713510.22450-100000@cafe.hardrock.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 April 2003 07:34:54 -0600, James Bourne wrote:
> 
> This patch has also been added to the update patch available at
> http://www.hardrock.org/kernel/current-updates/linux-2.4.20-updates.patch
> 
> This patch includes the ptrace patch, tg3 patch, and ext3 patches.  It also
> changes the EXTRAVERSION to -uv2.

Privately, I have introduced a variable FIXLEVEL for this. The
resulting kernel version is 2.4.20.2 instead of 2.4.20-uv2, which imo
is more suiting for a fixed stable kernel.

Are you interested in this patch?

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack
