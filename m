Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265572AbUFDEYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbUFDEYG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 00:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbUFDEYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 00:24:06 -0400
Received: from mfep1.odn.ne.jp ([143.90.131.179]:23034 "EHLO t-mta1.odn.ne.jp")
	by vger.kernel.org with ESMTP id S265572AbUFDEYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 00:24:04 -0400
Date: Sat, 5 Jun 2004 01:26:04 +0900
From: Aric Cyr <acyr@alumni.uwaterloo.ca>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nForce2 C1halt fixup, again
Message-ID: <20040605012604.A11737%acyr@alumni.uwaterloo.ca>
References: <20040604112618.A1789%acyr@alumni.uwaterloo.ca> <200406031712.51458.bzolnier@elka.pw.edu.pl> <20040604222004.A491%acyr@alumni.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604222004.A491%acyr@alumni.uwaterloo.ca>
User-Agent: Mutt/1.3.19i-ja0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 10:20:04PM +0900, Aric Cyr wrote:
> Thanks Bartlomiej.  I reversed my patch and have applied yours and am
> testing it now.  If my system doesn't freeze at all today, I think
> that this should be a sufficient (and necessary!) patch.

Well my system is still running strong after more than 3 hours, so I
think it is safe to say that your patch is working fine.  Thanks for
getting this fixed.  I hope it is in time for 2.6.7!

-- 
Aric Cyr <acyr at alumni dot uwaterloo dot ca>
