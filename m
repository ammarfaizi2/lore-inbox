Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317943AbSFNQEv>; Fri, 14 Jun 2002 12:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317944AbSFNQEu>; Fri, 14 Jun 2002 12:04:50 -0400
Received: from ns.suse.de ([213.95.15.193]:39695 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317943AbSFNQEu>;
	Fri, 14 Jun 2002 12:04:50 -0400
Date: Fri, 14 Jun 2002 18:04:51 +0200
From: Dave Jones <davej@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020614180451.R16772@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Benjamin LaHaise <bcrl@redhat.com>, Jens Axboe <axboe@suse.de>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D09F769.8090704@evision-ventures.com> <20020614151703.GB1120@suse.de> <20020614115634.B22888@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 11:56:34AM -0400, Benjamin LaHaise wrote:

 > Add my voice to these concerns.  At the very least the code should have 
 > been moved into a second tree to allow people to work with the old stable 
 > driver as needed.

*nod*, with periodic known-good _tested_ bits getting merged to
mainline, to avoid the need for an IDE merge flag day as has been
the norm in the past.

        Dave
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
