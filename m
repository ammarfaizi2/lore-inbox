Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTLAJZO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 04:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTLAJZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 04:25:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50655 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262355AbTLAJZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 04:25:09 -0500
Date: Mon, 1 Dec 2003 10:24:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS for 2.4
Message-ID: <20031201092446.GK6454@suse.de>
References: <20031201062052.GA2022@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201062052.GA2022@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01 2003, Nathan Scott wrote:
> Hi Marcelo,
> 
> Please do a
> 
> 	bk pull http://xfs.org:8090/linux-2.4+coreXFS
> 
> This will merge the core 2.4 kernel changes required for supporting
> the XFS filesystem, as listed below.  If this all looks acceptable,
> then please also pull the filesystem-specific code (fs/xfs/*)
> 
> 	bk pull http://xfs.org:8090/linux-2.4+justXFS

Where can these be found as a unified diff? It's quite bothersome to
have to pull a changeset just to review it (cloning a kernel tree
first), not to mention space intensive.

-- 
Jens Axboe

