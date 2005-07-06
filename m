Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVGFGSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVGFGSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 02:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVGFGRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 02:17:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29096 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261651AbVGFExr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 00:53:47 -0400
Date: Wed, 6 Jul 2005 14:46:26 +1000
From: Nathan Scott <nathans@sgi.com>
To: Al Boldi <a1426z@gawab.com>
Cc: "'Sonny Rao'" <sonny@burdell.org>, "'Jens Axboe'" <axboe@suse.de>,
       "'David Masover'" <ninja@slaphack.com>,
       "'Chris Wedgwood'" <cw@f00f.org>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: XFS corruption during power-blackout
Message-ID: <20050706044626.GA1773@frodo>
References: <20050705181057.GA16422@kevlar.burdell.org> <200507060424.HAA27591@raad.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507060424.HAA27591@raad.intranet>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 07:24:03AM +0300, Al Boldi wrote:
> Was ordered mode disabled/removed when XFS was add to the vanilla-kernel?

No, XFS has never supported such a mode.

cheers.

-- 
Nathan
