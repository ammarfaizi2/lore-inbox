Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278986AbRKFKwA>; Tue, 6 Nov 2001 05:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278968AbRKFKvu>; Tue, 6 Nov 2001 05:51:50 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:39057 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S278962AbRKFKvl>; Tue, 6 Nov 2001 05:51:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [Ext2-devel] disk throughput
Date: Tue, 6 Nov 2001 11:52:49 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <3BE647F4.AD576FF2@zip.com.au> <Pine.GSO.4.21.0111050904000.23204-100000@weyl.math.psu.edu> <3BE71131.59BA0CFC@zip.com.au>
In-Reply-To: <3BE71131.59BA0CFC@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011106105138Z16653-12382+40@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 5, 2001 11:22 pm, Andrew Morton wrote:
> - The seek distance-versus-cost equation has changed.  Take a look
>   at a graph of seek distance versus time.  Once you've decided to
>   seek ten percent of the distance across the disk, a 90% seek only
>   takes twice as long.

Do you have such a graph handy?

--
Daniel
