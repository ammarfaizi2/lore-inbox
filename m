Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289039AbSA3KCQ>; Wed, 30 Jan 2002 05:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289036AbSA3KCG>; Wed, 30 Jan 2002 05:02:06 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:32655 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289042AbSA3KBz>;
	Wed, 30 Jan 2002 05:01:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 11:05:42 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <mingo@elte.hu>, Rob Landley <landley@trommello.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201300110420.1542-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201300110420.1542-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Vrcc-0000DH-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 10:21 am, Linus Torvalds wrote:
> On Wed, 30 Jan 2002, Alexander Viro wrote:
> >
> > 	Frankly, the only real issue in that thread was that we _do_ need
> > a tree specifically for small fixes.  Preferably - quickly getting merged
> > into the main tree.
> 
> A "small stuff" maintainer may indeed be a good idea. The maintainer could
> be the same as somebody who does bigger stuff too, but they should be
> clearly different things - trivial one-liners that do not add anything
> new, only fix obvious stuff (to the point where nobody even needs to think
> about it - if I'd start getting any even halfway questionable patches from
> the "small stuff" maintainer, it wouldn't work).

But that's exactly what Arnaldo Carvalho de Melo[1] does, has been doing for 
more than a year, surely you've noticed?  On top of being the nicest guy in 
the world, as far as I can tell.

[1] Most of us call him <acme>.

-- 
Daniel
