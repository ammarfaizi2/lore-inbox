Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRACWt0>; Wed, 3 Jan 2001 17:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130319AbRACWtQ>; Wed, 3 Jan 2001 17:49:16 -0500
Received: from box-154.rosh.inter.net.il ([213.8.204.154]:55304 "EHLO
	callisto.yi.org") by vger.kernel.org with ESMTP id <S129771AbRACWtM>;
	Wed, 3 Jan 2001 17:49:12 -0500
Date: Thu, 4 Jan 2001 00:48:22 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Dan Hollis <goemon@anime.net>, linux-kernel <linux-kernel@vger.kernel.org>,
        mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.GSO.4.21.0101031716000.17363-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0101040037200.21774-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Alexander Viro wrote:

> > > > without breaking anything. It also reports of such calls by using printk.
> > > Get real.
> > 
> > Why do you always have to be insulting alex? Sheesh.
> 
> Sigh... Not intended to be an insult. Plain and simple advice. Idea is
[..]

Did you notice that question was ambiguous? I understood that sentence in
its other meaning, i.e, someone insulting Alex ;-)

Anyway, while it is agreed that you can't completely eliminate exploits,
it is recommended that, it should be at least harder to create them, maybe
it can even minimize the will to write them.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
