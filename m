Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUFDTRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUFDTRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265938AbUFDTRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:17:10 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14210 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265825AbUFDTRI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:17:08 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Aric Cyr <acyr@alumni.uwaterloo.ca>
Subject: Re: [PATCH] nForce2 C1halt fixup, again
Date: Fri, 4 Jun 2004 21:20:37 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20040604112618.A1789%acyr@alumni.uwaterloo.ca> <20040604222004.A491%acyr@alumni.uwaterloo.ca> <20040605012604.A11737%acyr@alumni.uwaterloo.ca>
In-Reply-To: <20040605012604.A11737%acyr@alumni.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406042120.37605.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 of June 2004 18:26, Aric Cyr wrote:
> On Fri, Jun 04, 2004 at 10:20:04PM +0900, Aric Cyr wrote:
> > Thanks Bartlomiej.  I reversed my patch and have applied yours and am
> > testing it now.  If my system doesn't freeze at all today, I think
> > that this should be a sufficient (and necessary!) patch.
>
> Well my system is still running strong after more than 3 hours, so I
> think it is safe to say that your patch is working fine.  Thanks for
> getting this fixed.  I hope it is in time for 2.6.7!

Thanks, this patch is merged now.

