Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUBXAyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUBXAyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:54:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11453 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262113AbUBXAyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:54:31 -0500
Date: Tue, 24 Feb 2004 00:54:29 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nathan Scott <nathans@sgi.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blkdev_open/bd_claim vs BLKBSZSET
Message-ID: <20040224005429.GG31035@parcelfarce.linux.theplanet.co.uk>
References: <20040223231705.GB773@frodo> <20040223232803.GD31035@parcelfarce.linux.theplanet.co.uk> <20040223235339.GC773@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223235339.GC773@frodo>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 10:53:39AM +1100, Nathan Scott wrote:
> No idea if that can still happen in 2.6, I imagine it can in 2.4
> where we originally saw the problem.

2.6 has none of that idiocy...
