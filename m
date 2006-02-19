Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWBSXAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWBSXAS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWBSXAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:00:18 -0500
Received: from mail.gmx.de ([213.165.64.20]:48517 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751124AbWBSXAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:00:17 -0500
X-Authenticated: #20450766
Date: Mon, 20 Feb 2006 00:00:40 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Nathan Scott <nathans@sgi.com>
cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RT, OOPS] 2.6.15.3-rt16 + XFS on USB => OOPS
In-Reply-To: <20060220083045.B9478997@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.60.0602200000130.3700@poirot.grange>
References: <Pine.LNX.4.60.0602192117530.3700@poirot.grange>
 <20060220083045.B9478997@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2006, Nathan Scott wrote:

> On Sun, Feb 19, 2006 at 09:26:06PM +0100, Guennadi Liakhovetski wrote:
> > Hi
> > 
> > Got the following Oops while trying to mount an XFS partition on a USB 
> > disk under 2.6.15.3-rt16:
> 
> This is fixed in 2.6.15.4.

Thanks!

Guennadi
---
Guennadi Liakhovetski
