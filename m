Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265179AbSKKX0S>; Mon, 11 Nov 2002 18:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbSKKX0S>; Mon, 11 Nov 2002 18:26:18 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:11648 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S265179AbSKKX0Q>; Mon, 11 Nov 2002 18:26:16 -0500
Date: Tue, 12 Nov 2002 10:32:45 +1100
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47 / unusual ext3 fs errors
Message-ID: <20021111233245.GA616@zip.com.au>
References: <20021111231053.GA1518@zip.com.au> <3DD03CDC.562D7C0@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD03CDC.562D7C0@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 03:27:24PM -0800, Andrew Morton wrote:
> CaT wrote:
> > And again, on reboot into single user mode and a full fsck bad inode
> > count errors were present. There were no errors detected whilst testing
> > the disk with -c.
> 
> There was a problem in 2.5.46 which mucked up these counters.  On disk.
> 
> 2.5.47 fixed that bug, and now you have fixed the on-disk mess which 2.5.46
> created, all should be well.

Sweet. Thanks. :)

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
