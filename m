Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSDPRGC>; Tue, 16 Apr 2002 13:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313316AbSDPRGB>; Tue, 16 Apr 2002 13:06:01 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:49315 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S312619AbSDPRGB>; Tue, 16 Apr 2002 13:06:01 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 16 Apr 2002 10:04:02 -0700 (PDT)
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <20020416172434.A1180@ucw.cz>
Message-ID: <Pine.LNX.4.44.0204161002420.3558-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Vojtech Pavlik wrote:

> Because for Linux filesystems it was decided some time ago (after people
> HAD huge byteswap problems) that ext2 is always LE, etc, etc. So
> filesystems are supposed to be the same on every system.

In the case of Tivo they are useing a kernel from the time before the fix
went in so even their ext2 partitions are incorrect (not to mention their
other partitions that aren't ext2)

David Lang
