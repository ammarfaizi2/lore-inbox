Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285368AbRLGBrQ>; Thu, 6 Dec 2001 20:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbRLGBrG>; Thu, 6 Dec 2001 20:47:06 -0500
Received: from dsl-213-023-043-086.arcor-ip.net ([213.23.43.86]:1799 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285366AbRLGBqy>;
	Thu, 6 Dec 2001 20:46:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>
Subject: Re: [PATCH] Revised extended attributes interface
Date: Fri, 7 Dec 2001 02:45:50 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <E16C0PD-0000ot-00@starship.berlin> <20011207101517.B46546@wobbly.melbourne.sgi.com>
In-Reply-To: <20011207101517.B46546@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16CA5I-0000rw-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 7, 2001 12:15 am, Nathan Scott wrote:
> > > (unless you go for a binary namespace representation, and that's a
> > > real can of worms).
> > 
> > I'm suggesting we take a look at that.
> 
> Andreas and I did have such an implementation, but we ditched it.
> The CVS revision history of cmd/attr2/{set,get}fattr/*.c in the XFS
> tree show the progression of user<->kernel interfaces which I tried
> while Andreas and I were nutting out a clean solution that we both
> could use.
> 
> Thar be dragons thar.  Big hairy ones.

Could you describe them, please?

--
Daniel
