Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129592AbQKASHv>; Wed, 1 Nov 2000 13:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129902AbQKASHl>; Wed, 1 Nov 2000 13:07:41 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:48199 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129592AbQKASHi>; Wed, 1 Nov 2000 13:07:38 -0500
Date: Wed, 1 Nov 2000 19:07:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001101190732.A19767@athlon.random>
In-Reply-To: <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com> <39FF49C8.475C2EA7@timpanogas.org> <20001101023010.G13422@athlon.random> <20001031183809.C9733@.timpanogas.org> <20001101164106.F9774@athlon.random> <3A005217.88D2CA0D@timpanogas.org> <3A005476.17F0F253@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A005476.17F0F253@timpanogas.org>; from jmerkey@timpanogas.org on Wed, Nov 01, 2000 at 10:35:50AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 10:35:50AM -0700, Jeff V. Merkey wrote:
> Wrong math.  That's 330 million dollars for each compat more each year to 
> fund more Linux development and make us all rich...

Speaking only for myself: on the technical side I don't think you can't be much
faster than moving the performance critical services into the kernel and by
skipping the copies (infact I also think that for fileserving skipping the
copies and making sendfile to work and to work in zero copy will be enough).
So I don't think losing robusteness this way can be explained in any technical
way and no, it's not by showing me money that you'll convince me that's a good
idea.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
