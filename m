Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273817AbRIRD0h>; Mon, 17 Sep 2001 23:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273819AbRIRD01>; Mon, 17 Sep 2001 23:26:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20250 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273817AbRIRD0Z>; Mon, 17 Sep 2001 23:26:25 -0400
Date: Tue, 18 Sep 2001 05:26:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918052650.O698@athlon.random>
In-Reply-To: <20010917221653.B31693@redhat.com> <Pine.LNX.4.33.0109171919330.1068-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109171919330.1068-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Sep 17, 2001 at 07:27:31PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 07:27:31PM -0700, Linus Torvalds wrote:
> Now, the VM part of the patch was certainly fairly big. I doubt much of it
> could have been reasonably split up, though.

Yes, I considered doing that but it would been quite a pain to develop
it incrementally (so I thought if needed I would have splitted it
later).

Andrea
