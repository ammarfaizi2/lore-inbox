Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130759AbRBQAfD>; Fri, 16 Feb 2001 19:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130833AbRBQAex>; Fri, 16 Feb 2001 19:34:53 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:21508 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130739AbRBQAef>;
	Fri, 16 Feb 2001 19:34:35 -0500
Date: Sat, 17 Feb 2001 01:34:23 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Matt D. Robinson" <yakker@alacritech.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux stifles innovation...
Message-ID: <20010217013422.A3055@almesberger.net>
In-Reply-To: <Pine.LNX.4.33.0102161843490.2548-100000@asdf.capslock.lan> <3A8DC2A7.43C7A5C3@alacritech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A8DC2A7.43C7A5C3@alacritech.com>; from yakker@alacritech.com on Fri, Feb 16, 2001 at 04:15:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt D. Robinson wrote:
> My feeling is we should splinter the kernel development for
> different purposes (enterprise, UP, security, etc.).  I'm sure
> it isn't a popular view, but I feel it would allow faster progression
> of kernel functionality and features in the long run.

"enterprise" XOR security ? I think you understand the problem with
your approach well ;-)

Linux scales well from PDAs to large clusters. This is quite an
achievement. Other operating systems are not able to match this.
So why do you think that Linux should try to mimic their flaws ?
Out of pity ?

BTW, parallel development does happen all the time. The point of
convergence in a single "mainstream" kernel is that you benefit
from all the work that's been going on while you did the stuff
you care most about.

- Werner (having pity with the hungry looking trolls)

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
