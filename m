Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273541AbRIQIkT>; Mon, 17 Sep 2001 04:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273544AbRIQIkI>; Mon, 17 Sep 2001 04:40:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26106 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273541AbRIQIj7>;
	Mon, 17 Sep 2001 04:39:59 -0400
Date: Mon, 17 Sep 2001 04:40:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9: multiply mounting filesystem
In-Reply-To: <3BA5BE90.29409.43AC7B@localhost>
Message-ID: <Pine.GSO.4.21.0109170440050.20053-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Sep 2001, Ulrich Windl wrote:

> Hi,
> 
> yesterday I mounted a filesystem /dev/sda9 (resierfs) twice (first time 
> as /, second time as /mnt) by mistake. Neither kernel nor mount program 
> complained. I'm very much afraid this could corrupt the filesystem. Or 
> is Linux really smart enough to handle the case?  

Yes.

