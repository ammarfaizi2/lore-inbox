Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130473AbQKASiQ>; Wed, 1 Nov 2000 13:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130984AbQKASh5>; Wed, 1 Nov 2000 13:37:57 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:30221 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130504AbQKAShs>; Wed, 1 Nov 2000 13:37:48 -0500
Message-ID: <3A00621F.7CC77F5A@timpanogas.org>
Date: Wed, 01 Nov 2000 11:34:07 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com> <39FF49C8.475C2EA7@timpanogas.org> <20001101023010.G13422@athlon.random> <20001031183809.C9733@.timpanogas.org> <20001101164106.F9774@athlon.random> <3A005217.88D2CA0D@timpanogas.org> <3A005476.17F0F253@timpanogas.org> <20001101190732.A19767@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:
> 
> On Wed, Nov 01, 2000 at 10:35:50AM -0700, Jeff V. Merkey wrote:
> > Wrong math.  That's 330 million dollars for each compat more each year to
> > fund more Linux development and make us all rich...
> 
> Speaking only for myself: on the technical side I don't think you can't be much
> faster than moving the performance critical services into the kernel and by
> skipping the copies (infact I also think that for fileserving skipping the
> copies and making sendfile to work and to work in zero copy will be enough).
> So I don't think losing robusteness this way can be explained in any technical
> way and no, it's not by showing me money that you'll convince me that's a good
> idea.
> 
> Andrea

This would help, but not as much as full ring 0.

Jeff

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
