Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262108AbSJIWGF>; Wed, 9 Oct 2002 18:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262109AbSJIWGF>; Wed, 9 Oct 2002 18:06:05 -0400
Received: from holomorphy.com ([66.224.33.161]:28902 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262108AbSJIWGE>;
	Wed, 9 Oct 2002 18:06:04 -0400
Date: Wed, 9 Oct 2002 15:08:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  October 9, 2002
Message-ID: <20021009220834.GJ12432@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <3DA41B88.14599.2336B580@localhost> <3DA46D3F.24793.2475E9B6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA46D3F.24793.2475E9B6@localhost>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 05:54:07PM -0400, Guillaume Boissiere wrote:
> Did I???  Ooops... not intended, sorry about that.
> I had put them on hold to find out from you which 
> version they had been merged at (couldn't find it in the
> log) and then forgot about it.
> If you can give me the info, I'll put them back.
> Thanks,

Remove (iteration over) global tasklist (Ingo, me):
	merged 2.5.37

Parallelizing page replacement (velco, akpm, dhansen, me):
	last steps of the per-zone LRU lists, locks, and per-node
	kswapd's merged as of 2.5.40, per-inode pagecache locking
	merged centuries ago (with the ratcache).


Bill
