Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273166AbRIJCln>; Sun, 9 Sep 2001 22:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273167AbRIJCld>; Sun, 9 Sep 2001 22:41:33 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:2246 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S273169AbRIJCl3>; Sun, 9 Sep 2001 22:41:29 -0400
Date: Sun, 09 Sep 2001 22:41:47 -0400
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
Message-ID: <1337070000.1000089707@tiny>
In-Reply-To: <Pine.LNX.4.33.0109091901130.23952-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109091901130.23952-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, September 09, 2001 07:03:46 PM -0700 Linus Torvalds
<torvalds@transmeta.com> wrote:

>> Anyway, the whole thing can be cut down to a smallish patch, either alone
>> or on top of andrea's stuff.  Daniel, if you want to work together on it,
>> I'm game.
> 
> If you'd be willing to integrate your patches on top of andreas (and
> massage them to be the _only_ getblk interface) and look what the
> resulting thing looks like, I bet that there will be a lot of people
> interested in working on any final remaining issues.

Ok, the getblk interace wasn't really tied to the rest of the patch, so it
should be easy to cut out.  I'll give it a go a little later in the week,
I'm still catching up from sick days last week ;-)

-chris

