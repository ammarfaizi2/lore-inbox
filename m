Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLWUlN>; Sat, 23 Dec 2000 15:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbQLWUky>; Sat, 23 Dec 2000 15:40:54 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:857 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129458AbQLWUkt>; Sat, 23 Dec 2000 15:40:49 -0500
Date: Sat, 23 Dec 2000 21:10:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Todd M. Roy" <toddroy@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lvm 0.8 to 0.9 conversion?
Message-ID: <20001223211017.A29082@athlon.random>
In-Reply-To: <3A44FBF7.46EDB9EB@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A44FBF7.46EDB9EB@softhome.net>; from toddroy@softhome.net on Sat, Dec 23, 2000 at 02:24:39PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2000 at 02:24:39PM -0500, Todd M. Roy wrote:
> 
> Now that in 2.4.0-test12-pre4, lvm 0.9 has replaced 0.8, is it possible
> to do a conversion of lvm created physical volumes, volume groups
> and logical volumes from 0.8 to 0.9?

on-disk format isn't changed so no conversion is needed. You only
need to upgrade the lvm tools to use the new kernel driver, grab the tools from
www.sistina.com.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
