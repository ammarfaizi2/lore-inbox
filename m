Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267460AbUHJHLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUHJHLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 03:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267455AbUHJHLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 03:11:08 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:16271 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S267460AbUHJHLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 03:11:05 -0400
Date: Tue, 10 Aug 2004 09:10:50 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] via-rhine: experimental patches
Message-ID: <20040810071050.GC11224@k3.hellgate.ch>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040808140216.GA8181@k3.hellgate.ch> <1092103694.761.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092103694.761.5.camel@mindpipe>
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Aug 2004 22:08:14 -0400, Lee Revell wrote:
> On Sun, 2004-08-08 at 10:02, Roger Luethi wrote:
> > The following batch needs testing. I don't expect any notable
> > regressions, but I could do with some reports on WOL (already in -mm)
> > and suspend/resume.
> 
> Maybe this is a known issue by now, but the via-rhine bug is still not
> fixed in 2.6.8-rc3.  I had to replace it with the via-rhine.c from -mm2
> to get online.

It is known. The fix for that bug is simmering in the pipeline
somewhere. The experimental patches OTOH were for -mm and unrelated.

Roger
