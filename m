Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135974AbRDTQv3>; Fri, 20 Apr 2001 12:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135967AbRDTQvJ>; Fri, 20 Apr 2001 12:51:09 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:56080 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135974AbRDTQvE>;
	Fri, 20 Apr 2001 12:51:04 -0400
Date: Fri, 20 Apr 2001 12:50:05 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Tom Rini <trini@kernel.crashing.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>,
        lkml <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010420125005.B8086@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Nicolas Pitre <nico@cam.org>, Tom Rini <trini@kernel.crashing.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Matthew Wilcox <willy@ldl.fc.hp.com>,
	james rich <james.rich@m.cc.utah.edu>,
	lkml <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org
In-Reply-To: <20010420085148.V13403@opus.bloom.county> <Pine.LNX.4.33.0104201206250.12186-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104201206250.12186-100000@xanadu.home>; from nico@cam.org on Fri, Apr 20, 2001 at 12:35:12PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre <nico@cam.org>:
> Why not having everybody's tree consistent with themselves and have whatever
> CONFIGURE_* symbols and help text be merged along with the very code it
> refers to?  It's worthless to have config symbols be merged into Linus' or
> Alan's tree if the code isn't there (yet).  It simply makes no sense.

And now it has a cost, too.  It makes finding real bugs more difficult.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Every election is a sort of advance auction sale of stolen goods. 
	-- H.L. Mencken 
