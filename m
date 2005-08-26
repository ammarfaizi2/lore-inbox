Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVHZTKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVHZTKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVHZTKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:10:22 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:22156 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1030203AbVHZTKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:10:20 -0400
X-ORBL: [67.124.117.85]
Date: Fri, 26 Aug 2005 12:10:12 -0700
From: Chris Wedgwood <cw@f00f.org>
To: robotti@godmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050826191012.GC12296@taniwha.stupidest.org>
References: <200508251538.j7PFcn1g000143@ms-smtp-01.rdc-nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508251538.j7PFcn1g000143@ms-smtp-01.rdc-nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 11:38:49AM -0400, robotti@godmail.com wrote:

> What if you have a root.cpio.gz that requires 200MB to hold, but you
> only have 300MB of memory?

then it won't work with nay of the schemes you've suggested

> 50% of total memory wouldn't hold it, but 90% etc. would (tmpfs_size=90%).

no, actually it won't
