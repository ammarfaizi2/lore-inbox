Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135921AbRDTNx4>; Fri, 20 Apr 2001 09:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135924AbRDTNxr>; Fri, 20 Apr 2001 09:53:47 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:28176 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135921AbRDTNxe>;
	Fri, 20 Apr 2001 09:53:34 -0400
Date: Fri, 20 Apr 2001 09:53:02 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010420095302.A5674@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Matthew Wilcox <willy@ldl.fc.hp.com>,
	james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
	parisc-linux@parisc-linux.org
In-Reply-To: <20010420093538.A5525@thyrsus.com> <E14qbCT-0001IF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14qbCT-0001IF-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Apr 20, 2001 at 02:43:49PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > > I have for one. Its definitely the wrong approach to bomb Linus
> > > with patches when doing the merge of an architecture. All the
> > > architecture folk with in their own trees for good reason.
> > 
> > On the other hand, Linus has objected to the One-Big-Patch approach in
> > the past with respect to things like the networking and VM code.  How
> > are people to know what the right thing is?
> 
> Who said anything about one big patch ?  Just because you have a lot
> of differences doesnt mean you send Linus one giant splat of code. I
> don't send Linus -ac for example.

OK, so maybe I'm being stupid.  But the implication of this talk of separate
port trees and architecture merges is that these guys periodically send big
resync patches to you and Linus.

If that's not what's going on, what is?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Never could an increase of comfort or security be a sufficient good to be
bought at the price of liberty.
	-- Hillaire Belloc
