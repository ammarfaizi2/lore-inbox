Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbRB0RTk>; Tue, 27 Feb 2001 12:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRB0RTb>; Tue, 27 Feb 2001 12:19:31 -0500
Received: from customer-VER-208-19.megared.net.mx ([200.52.208.19]:43020 "EHLO
	bsd.ver.megared.net.mx") by vger.kernel.org with ESMTP
	id <S129663AbRB0RTU>; Tue, 27 Feb 2001 12:19:20 -0500
Date: Tue, 27 Feb 2001 11:18:56 -0600
From: MC_Vai <estoy@ver.megared.net.mx>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Massive Corruption
Message-ID: <20010227111856.B19206@lapurapus.ver.megared.net.mx>
In-Reply-To: <20010226181009.B25911@lapurapus.ver.megared.net.mx> <200102271650.f1RGoGr27040@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102271650.f1RGoGr27040@webber.adilger.net>; from adilger@turbolinux.com on Tue, Feb 27, 2001 at 09:50:16AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 09:50:16AM -0700, Andreas Dilger wrote:
> 
> There is a tool called gpart which will search a disk for filesystem
> headers and such, and will optionally re-build your partition table
> (if it is corrupted).  You should give it a try.

	I will thanks, but I must say that I did already
	rewrite the partition table.
	i.e., I wrote in a paper the values of my previous
	partition table, then I delete all the linux
	partitions and finally I rewrote them again (with
	the same values it had).  But it doesn't work  =-(

	But I'm gonna try with gpart and I'll tell you if
	it works.

	Thank you.
	Regards,

	                           Eduardo.
