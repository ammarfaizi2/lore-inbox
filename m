Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290377AbSAQUYi>; Thu, 17 Jan 2002 15:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290441AbSAQUY3>; Thu, 17 Jan 2002 15:24:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:51623 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290440AbSAQUYM>;
	Thu, 17 Jan 2002 15:24:12 -0500
Date: Thu, 17 Jan 2002 15:24:01 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: bread() seems reading bogus data ...
In-Reply-To: <Pine.LNX.4.40.0201161920530.935-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.GSO.4.21.0201171523430.11155-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Jan 2002, Davide Libenzi wrote:

> 
> 
> Linus,
> 
> it seems that __bread() read wrong data on my disk resulting in a ext2
> magic of 0x8001 ?!?, reading from /dev/hda5 03:05
> Below is reported a dmesg from my machine when booted with 2.5.2
> Are you able to guess something or do i need to drill more ?

Which version?

