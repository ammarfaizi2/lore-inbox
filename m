Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVHOGNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVHOGNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 02:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVHOGNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 02:13:37 -0400
Received: from pop.gmx.net ([213.165.64.20]:49885 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932078AbVHOGNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 02:13:37 -0400
X-Authenticated: #20450766
Date: Mon, 15 Aug 2005 08:12:32 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] scsi bug fixes for 2.6.13
In-Reply-To: <1124048890.18802.13.camel@mulgrave>
Message-ID: <Pine.LNX.4.60.0508150811580.5302@poirot.grange>
References: <1123184634.5026.58.camel@mulgrave>  <Pine.LNX.4.60.0508142121000.4594@poirot.grange>
 <1124048890.18802.13.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005, James Bottomley wrote:

> OK, why don't we do this.  Instead of having me trawl through the trees
> looking for the correct patch to reverse, why don't you attach it in an
> email and I'll try to get it in to 2.6.13?

Looks like just reverting that patch is not enough. More in about 12 
hours.

Guennadi
---
Guennadi Liakhovetski
