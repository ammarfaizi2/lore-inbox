Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267465AbUHJHPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267465AbUHJHPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 03:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUHJHPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 03:15:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11673 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267465AbUHJHPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 03:15:51 -0400
Subject: Re: [0/3] via-rhine: experimental patches
From: Lee Revell <rlrevell@joe-job.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040810071050.GC11224@k3.hellgate.ch>
References: <20040808140216.GA8181@k3.hellgate.ch>
	 <1092103694.761.5.camel@mindpipe>  <20040810071050.GC11224@k3.hellgate.ch>
Content-Type: text/plain
Message-Id: <1092122167.829.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 03:16:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 03:10, Roger Luethi wrote:
> On Mon, 09 Aug 2004 22:08:14 -0400, Lee Revell wrote:
> > On Sun, 2004-08-08 at 10:02, Roger Luethi wrote:
> > > The following batch needs testing. I don't expect any notable
> > > regressions, but I could do with some reports on WOL (already in -mm)
> > > and suspend/resume.
> > 
> > Maybe this is a known issue by now, but the via-rhine bug is still not
> > fixed in 2.6.8-rc3.  I had to replace it with the via-rhine.c from -mm2
> > to get online.
> 
> It is known. The fix for that bug is simmering in the pipeline
> somewhere. The experimental patches OTOH were for -mm and unrelated.
> 

OK, just wanted to make sure the fix gets into 2.6.8, because it can be
a showstopper.

Lee

