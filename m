Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWJETLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWJETLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWJETLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:11:47 -0400
Received: from mail.gmx.de ([213.165.64.20]:7553 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750784AbWJETLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:11:45 -0400
X-Authenticated: #20450766
Date: Thu, 5 Oct 2006 21:11:09 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] scsi updates for post 2.6.18
In-Reply-To: <1159995678.3437.80.camel@mulgrave.il.steeleye.com>
Message-ID: <Pine.LNX.4.60.0610052104330.6619@poirot.grange>
References: <1159995678.3437.80.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006, James Bottomley wrote:

> This is (hopefully) my final batch of updates before we go -rc1.  It's
> mainly code cleanups, some driver updates and the new qla4xxx iScsi
> driver.

James, is there a reason why you didn't include this one:

http://marc.theaimsgroup.com/?l=linux-scsi&m=115974328128341&w=2

Do you think it can cause problems?

Thanks
Guennadi
---
Guennadi Liakhovetski
