Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273917AbRIRUxL>; Tue, 18 Sep 2001 16:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273914AbRIRUwv>; Tue, 18 Sep 2001 16:52:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24731 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273911AbRIRUwq>;
	Tue, 18 Sep 2001 16:52:46 -0400
Date: Tue, 18 Sep 2001 16:53:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <200109182033.f8IKXPZ14069@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0109181648001.27538-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Richard Gooch wrote:

> Alexander Viro writes:
> > "I can't be arsed to split my K'R4D 3133t 200Kb p47cH" had lost its
> > charm years ago - just look at the devfs mess...
> 
> Al, are you ever going to stop bitching and moaning about devfs?
> If you have a specific, technical, reasoned complaint to make, do it
> coherently. Otherwise, stop sniping.

What?  I'm saying that devfs was a huge patch which was not understood
(let alone audited) by anyone except you when it was included and as
the direct result we have a long history of problems in that area.
You want to argue against that?

If you still feel that feeding devfs into the tree in one huge chunk was
not a mistake - you are much dumber than I thought.

