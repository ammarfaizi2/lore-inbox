Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbRDQAzT>; Mon, 16 Apr 2001 20:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbRDQAzE>; Mon, 16 Apr 2001 20:55:04 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:1550 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132485AbRDQAyv>;
	Mon, 16 Apr 2001 20:54:51 -0400
Date: Mon, 16 Apr 2001 20:55:56 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: james rich <james.rich@m.cc.utah.edu>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML2 1.1.3 is available
Message-ID: <20010416205556.A22960@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <3ADB69BF.7040305@reutershealth.com> <Pine.GSO.4.05.10104161622110.17365-100000@pipt.oz.cc.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.05.10104161622110.17365-100000@pipt.oz.cc.utah.edu>; from james.rich@m.cc.utah.edu on Mon, Apr 16, 2001 at 04:28:18PM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

james rich <james.rich@m.cc.utah.edu>:
> > Instead, read the colors from the .Xdefaults system.
> 
> Yes, truly this should be done.  Sensible defaults should be used (and I
> think we may be at that point) and then use .Xdefaults (.Xresources or
> whatever) to allow site overrides.  And I really do think .Xdefaults and
> not .xconfigrc or something.  I've already got enough .files and I like
> the syntax of .Xdefaults.

That way lies featuritis, IMO.

If there were already a library in ths stock Python distribution to digest
.Xdefaults files I might consider this.  Perhaps I'll write one.  But I'm
not going to bulk up the CML2 code with this marginal feature.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The conclusion is thus inescapable that the history, concept, and 
wording of the second amendment to the Constitution of the United 
States, as well as its interpretation by every major commentator and 
court in the first half-century after its ratification, indicates 
that what is protected is an individual right of a private citizen 
to own and carry firearms in a peaceful manner.
         -- Report of the Subcommittee On The Constitution of the Committee On 
            The Judiciary, United States Senate, 97th Congress, second session 
            (February, 1982), SuDoc# Y4.J 89/2: Ar 5/5
