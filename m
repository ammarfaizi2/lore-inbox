Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbULWPC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbULWPC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 10:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbULWPC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 10:02:57 -0500
Received: from unthought.net ([212.97.129.88]:11913 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261247AbULWPB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 10:01:58 -0500
Date: Thu, 23 Dec 2004 16:01:57 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Christoph Hellwig <hch@infradead.org>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20041223150156.GK347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Christoph Hellwig <hch@infradead.org>, Jan Kasprzak <kas@fi.muni.cz>,
	linux-kernel@vger.kernel.org, kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net> <20041222182344.GB14586@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222182344.GB14586@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 06:23:44PM +0000, Christoph Hellwig wrote:
...
> I have a better patch than the one I gave you (attached below).  If you
> send me a mail with steps to reproduce your remaining problems I'll put
> this very high on my TODO list after christmas.  Btw, any chance you could
> try XFS CVS (which is at 2.6.9) + the patch below instead of plain 2.6.9,
> there have been various other fixes in the last months.

Thank you Christoph,

I will see what I can do - my schedule is a little tight these days, but
I'll try it out at the first given opportunity (which will definitely be
after christmas but hopefully before new year).

-- 

 / jakob

