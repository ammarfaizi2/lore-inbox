Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136275AbRDVTRK>; Sun, 22 Apr 2001 15:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136276AbRDVTQv>; Sun, 22 Apr 2001 15:16:51 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:37125 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136275AbRDVTQi>; Sun, 22 Apr 2001 15:16:38 -0400
Date: Sun, 22 Apr 2001 21:16:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "D . W . Howells" <dhowells@astarte.free-online.co.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dhowells@redhat.com,
        davem@redhat.com
Subject: Re: [PATCH] rw_semaphores, optimisations
Message-ID: <20010422211629.A21558@athlon.random>
In-Reply-To: <01042201272000.01091@orion.ddi.co.uk> <20010422210703.G10226@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010422210703.G10226@athlon.random>; from andrea@suse.de on Sun, Apr 22, 2001 at 09:07:03PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 09:07:03PM +0200, Andrea Arcangeli wrote:
> On Sun, Apr 22, 2001 at 01:27:20AM +0100, D . W . Howells wrote:

btw, I noticed I answered your previous email but for my benchmarks I really
used your latest #try2 posted today at 13 (not last night a 1am), just to avoid
mistakes this is the the md5sum of the patch I applied on top of pre6:

	510c05d168c2b60e0d9c804381579b51  rwsem.diff

Andrea
