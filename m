Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314442AbSEFNEG>; Mon, 6 May 2002 09:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314443AbSEFNEF>; Mon, 6 May 2002 09:04:05 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:24077 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314442AbSEFNEF>; Mon, 6 May 2002 09:04:05 -0400
Date: Mon, 6 May 2002 15:03:56 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Ivan G." <ivangurdiev@linuxfreemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 keyboard timeout
Message-ID: <20020506130355.GA11676@louise.pinerecords.com>
In-Reply-To: <02050602144500.00976@cobra.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 14 days, 7:37)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try booting with 'acpi=off' and search the lkml archives for '2.5, keyboard'.
T.


> [Ivan G. <ivangurdiev@linuxfreemail.com>, May-06 2002, Mon, 02:14 -0600]
> May  6 01:49:51 cobra kernel: keyboard: Timeout - AT keyboard not present?(ed)
> problem exists for both 2.5.13 and 2.5.14 ( i wasn't able to get earlier 
> kernels to work)
> 
> When X boots, the mouse works. Mouse freezes on attempt to type anything with 
> the keyboard. Single - user mode: keyboard is dead by the time I need to type 
> the root password.
> 
> Keyboard works fine with 2.4 kernels 
