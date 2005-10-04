Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVJDI7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVJDI7l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 04:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVJDI7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 04:59:41 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:8368 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750815AbVJDI7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 04:59:40 -0400
Date: Tue, 4 Oct 2005 10:59:39 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jay Lan <jlan@engr.sgi.com>, Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
Message-ID: <20051004085939.GA6672@janus>
References: <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com> <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com> <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus> <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com> <4339AED4.8030108@engr.sgi.com> <Pine.LNX.4.61.0509281337420.6830@goblin.wat.veritas.com> <433AD359.8070509@engr.sgi.com> <Pine.LNX.4.61.0510032030320.13179@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510032030320.13179@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 08:53:09PM +0100, Hugh Dickins wrote:
> 
> Christoph, Frank, Jay: does this patch look like it fits your needs?

Yes.  Thanks.


-- 
Frank
