Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbSKBIg0>; Sat, 2 Nov 2002 03:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265896AbSKBIg0>; Sat, 2 Nov 2002 03:36:26 -0500
Received: from vitelus.com ([64.81.243.207]:55561 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S265895AbSKBIgZ>;
	Sat, 2 Nov 2002 03:36:25 -0500
Date: Sat, 2 Nov 2002 00:42:27 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>, hpa@zytor.com, viro@math.psu.edu
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
Message-ID: <20021102084226.GA7800@vitelus.com>
References: <3DC38939.90001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC38939.90001@pobox.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 03:13:45AM -0500, Jeff Garzik wrote:
> The Future.
> 
> Early userspace is going to be merged in a series of evolutionary 
> changes, following what I call "The Al Viro model."  NO KERNEL BEHAVIOR 
> SHOULD CHANGE.  [that's for the lkml listeners, not you <g>]  "make" 
> will continue to simply Do The Right Thing(tm) on all platforms, while 
> the kernel image continues to get progressively smaller.

Won't the initial userspace be linked into the kernel? If so, why will
the kernel image get smaller?
