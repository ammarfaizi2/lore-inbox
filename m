Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289341AbSA3QK0>; Wed, 30 Jan 2002 11:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289354AbSA3QKE>; Wed, 30 Jan 2002 11:10:04 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:42912
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289377AbSA3QIo>; Wed, 30 Jan 2002 11:08:44 -0500
Date: Wed, 30 Jan 2002 09:07:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@work.bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130160707.GL25973@opus.bloom.county>
In-Reply-To: <E16Vp2w-0000CA-00@starship.berlin> <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com> <20020130154233.GK25973@opus.bloom.county> <20020130080308.D18381@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130080308.D18381@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:03:08AM -0800, Larry McVoy wrote:
> On Wed, Jan 30, 2002 at 08:42:33AM -0700, Tom Rini wrote:
> > On Tue, Jan 29, 2002 at 11:48:05PM -0800, Linus Torvalds wrote:
> > It does in some ways anyhow.  Following things downstream is rather
> > painless, but one of the things we in the PPC tree hit alot is when we
> > have a new file in one of the sub trees and want to move it up to the
> > 'stable' tree
> 
> Summary: only an issue because Linus isn't using BK.

Then how do we do this in the bk trees period?  To give a concrete
example, I want to move arch/ppc/platforms/prpmc750_setup.c from
2_4_devel into 2_4, without loosing history.  How?  And just this file
and not all of _devel.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
