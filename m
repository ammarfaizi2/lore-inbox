Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132327AbRDUAZl>; Fri, 20 Apr 2001 20:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132337AbRDUAZc>; Fri, 20 Apr 2001 20:25:32 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:2066 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132327AbRDUAZ0>;
	Fri, 20 Apr 2001 20:25:26 -0400
Date: Fri, 20 Apr 2001 20:24:53 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Nicolas Pitre <nico@cam.org>, Tom Rini <trini@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>,
        lkml <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010420202453.B21392@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>, Nicolas Pitre <nico@cam.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Matthew Wilcox <willy@ldl.fc.hp.com>,
	james rich <james.rich@m.cc.utah.edu>,
	lkml <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org
In-Reply-To: <20010420173514.A21392@thyrsus.com> <20010420172435.A21252@thyrsus.com> <Pine.LNX.4.33.0104201440580.12186-100000@xanadu.home> <6817.987801548@redhat.com> <20010420172435.A21252@thyrsus.com> <7043.987802140@redhat.com> <20010420173514.A21392@thyrsus.com> <7261.987802764@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7261.987802764@redhat.com>; from dwmw2@infradead.org on Fri, Apr 20, 2001 at 10:39:24PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> esr@thyrsus.com said:
> >  Even supposing that's so, a 36% rate of broken symbols is way too
> > high.  It argues that we need to do a thorough housecleaning at least
> > once in order to get back to an acceptably low stable rate.
> 
> Accepted. Can we let the 2.4 "angry penguin"-enforced stabilising period
> finish, and give the arch and subsystem maintainers a chance to finally
> brave the wrath of Linus and submit their patches, before we attempt do to
> it though?

I guess so.  We don't particularly have a choice, do we? :-)
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Government is not reason, it is not eloquence, it is force; like fire, a
troublesome servant and a fearful master. Never for a moment should it be left
to irresponsible action."
	-- George Washington, in a speech of January 7, 1790
