Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135556AbRDSFhe>; Thu, 19 Apr 2001 01:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135557AbRDSFhY>; Thu, 19 Apr 2001 01:37:24 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:25609 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135556AbRDSFhL>;
	Thu, 19 Apr 2001 01:37:11 -0400
Date: Thu, 19 Apr 2001 01:37:48 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Richard Gooch <rgooch@atnf.csiro.au>
Cc: "Edward S. Marshall" <esm@logic.net>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Cross-referencing frenzy
Message-ID: <20010419013748.C29686@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Richard Gooch <rgooch@atnf.csiro.au>,
	"Edward S. Marshall" <esm@logic.net>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104190400.f3J40Dm00992@mobilix.atnf.CSIRO.AU> <Pine.LNX.4.21.0104190109480.1685-100000@imladris.rielhome.conectiva> <20010418233618.A28546@labyrinth.local> <200104190506.f3J56ik01292@mobilix.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104190506.f3J56ik01292@mobilix.atnf.CSIRO.AU>; from rgooch@atnf.csiro.au on Thu, Apr 19, 2001 at 03:06:44PM +1000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch <rgooch@atnf.csiro.au>:
> > Look at the filename. ;-) They're not being kept around, they just
> > happen to be mentioned in the devfs ChangeLog, and esr's overzealous
> > crossref tool caught them. *grin*

I've already fixed that.
 
> A cleaner solution is to parse the source code, ignoring comment
> blocks. However, that's a bit more work.

Not too hard.  I think I can do that.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Non-cooperation with evil is as much a duty as cooperation with good.
	-- Mohandas Gandhi
