Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267231AbUGVU30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267231AbUGVU30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUGVU30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:29:26 -0400
Received: from europa.pnl.gov ([130.20.248.195]:54475 "EHLO europa.pnl.gov")
	by vger.kernel.org with ESMTP id S267231AbUGVU3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:29:24 -0400
Date: Thu, 22 Jul 2004 13:28:27 -0700
From: Kevin Fox <Kevin.Fox@pnl.gov>
Subject: Re: New dev model (was [PATCH] delete devfs)
In-reply-to: <20040722160112.177fc07f.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, corbet@lwn.net, linux-kernel@vger.kernel.org
Message-id: <1090528107.10227.4.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <40FEEEBC.7080104@quark.didntduck.org>
 <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de>
 <20040722025539.5d35c4cb.akpm@osdl.org> <20040722193337.GE19329@fs.tum.de>
 <20040722160112.177fc07f.akpm@osdl.org>
X-OriginalArrivalTime: 22 Jul 2004 20:29:23.0140 (UTC)
 FILETIME=[930F3040:01C4702A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How is this any different then the old dev model with very short release
cycles? (Other then keeping a "2." prefixed forever)

On Thu, 2004-07-22 at 16:01, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > my personal opinon is that this new development model isn't a good 
> > idea from the point of view of users:
> > 
> > There's much worth in having a very stable kernel. Many people use for 
> > different reasons self-compiled ftp.kernel.org kernels. 
> 
> Well.  We'll see.  2.6 is becoming stabler, despite the fact that we're
> adding features.
> 
> I wouldn't be averse to releasing a 2.6.20.1 which is purely stability
> fixes against 2.6.20 if there is demand for it.  Anyone who really cares
> about stability of kernel.org kernels won't be deploying 2.6.20 within a
> few weeks of its release anyway, so by the time they doodle over to
> kernel.org they'll find 2.6.20.2 or whatever.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
