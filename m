Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWFTGwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWFTGwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWFTGwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:52:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41671 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965100AbWFTGwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:52:24 -0400
Date: Tue, 20 Jun 2006 16:52:09 +1000
From: Nathan Scott <nathans@sgi.com>
To: Avuton Olrich <avuton@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Message-ID: <20060620165209.C1080488@wobbly.melbourne.sgi.com>
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com> <20060620161006.C1079661@wobbly.melbourne.sgi.com> <3aa654a40606192338v751150fp5645d1d2943316ea@mail.gmail.com> <20060620164338.A1080488@wobbly.melbourne.sgi.com> <3aa654a40606192350w5c469670t466dfc1344e23a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3aa654a40606192350w5c469670t466dfc1344e23a4@mail.gmail.com>; from avuton@gmail.com on Mon, Jun 19, 2006 at 11:50:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 11:50:37PM -0700, Avuton Olrich wrote:
> On 6/19/06, Nathan Scott <nathans@sgi.com> wrote:
> > Oh - thats a kernel patch, not a repair patch, I was more interested
> > in whether the initial corruption could be reproduced.  Which version
> > of xfs_repair are you running?  (xfs_repair -V)  xfsprogs-2.7.18 will
> > resolve your problem, I suspect.
> 
> OK, I'm running Gentoo's latest: 2.7.11, I can't find 2.7.18
> _anywhere_ although 2.7.13 is in the pre directory on the ftp, is that
> the one you're referring to?

No - its in CVS (for a long time); I'll go get the ftp area updated,
looks like thats been forgotten about again.

cheers.

-- 
Nathan
