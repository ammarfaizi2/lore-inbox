Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130779AbRBGBFM>; Tue, 6 Feb 2001 20:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130785AbRBGBEw>; Tue, 6 Feb 2001 20:04:52 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:18 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130779AbRBGBEq>; Tue, 6 Feb 2001 20:04:46 -0500
Date: Tue, 6 Feb 2001 18:59:32 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206185932.A23960@vger.timpanogas.org>
In-Reply-To: <20010206185115.A23754@vger.timpanogas.org> <Pine.LNX.4.30.0102070157560.14418-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0102070157560.14418-100000@elte.hu>; from mingo@elte.hu on Wed, Feb 07, 2001 at 02:01:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 02:01:54AM +0100, Ingo Molnar wrote:
> 
> On Tue, 6 Feb 2001, Jeff V. Merkey wrote:
> 
> > I remember Linus asking to try this variable buffer head chaining
> > thing 512-1024-512 kind of stuff several months back, and mixing them
> > to see what would happen -- result. About half the drivers break with
> > it. [...]
> 
> time to fix them then - instead of rewriting the rest of the kernel ;-)
> 
> 	Ingo

I agree.  

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
