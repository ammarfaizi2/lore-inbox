Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbVIDKOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVIDKOH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 06:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVIDKOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 06:14:07 -0400
Received: from verein.lst.de ([213.95.11.210]:56240 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751338AbVIDKOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 06:14:05 -0400
Date: Sun, 4 Sep 2005 12:13:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: xfs-masters@oss.sgi.com
Cc: Andrew Morton <akpm@osdl.org>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [xfs-masters] [2.6 patch] fs/xfs/linux-2.6/xfs_buf.h: "extern inline" doesn't make sense
Message-ID: <20050904101349.GA15281@lst.de>
References: <20050903132347.GN3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050903132347.GN3657@stusta.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 03:23:47PM +0200, Adrian Bunk wrote:
> "extern inline" doesn't make sense.

Thanks, I put this in.

