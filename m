Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbULNAkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbULNAkM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 19:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbULNAkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 19:40:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48284 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261357AbULNAkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 19:40:09 -0500
Date: Tue, 14 Dec 2004 11:36:56 +1100
From: Nathan Scott <nathans@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] some XFS cleanups (fwd)
Message-ID: <20041214003656.GA1215@frodo>
References: <20041207193533.GG7250@stusta.de> <20041208050348.GI1611@frodo> <20041214000621.GO23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214000621.GO23151@stusta.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 01:06:21AM +0100, Adrian Bunk wrote:
> 
> Would it be OK to make vfs_dmapiops #ifdef on the DMAPI code?
> 

Yep, that should be fine.

cheers.

-- 
Nathan
