Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287573AbSAFWjk>; Sun, 6 Jan 2002 17:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288902AbSAFWja>; Sun, 6 Jan 2002 17:39:30 -0500
Received: from dsl-213-023-043-049.arcor-ip.net ([213.23.43.49]:29450 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287573AbSAFWjL>;
	Sun, 6 Jan 2002 17:39:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Date: Sun, 6 Jan 2002 23:42:28 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <5.1.0.14.2.20020105145226.03163170@pop.cus.cam.ac.uk> <5.1.0.14.2.20020106035716.02c49b80@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20020106035716.02c49b80@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NLzo-0001Ld-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> To be honest I fail to see how one additional slab allocation will make 
> any difference.                                                      /
                                                                      /
You could say the same about any aspect of Linux: and, relaxing your /
standards in such a way, you would inevitably end up with a dog.  A /
good fast system emerges from its many small perfections.  Half of /
the number of cache entries for inodes qualifies as one of those. /
_________________________________________________________________/
----------------------------------------------------------------
Daniel
