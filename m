Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283692AbRLDOmG>; Tue, 4 Dec 2001 09:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284389AbRLDOlu>; Tue, 4 Dec 2001 09:41:50 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:7603
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283200AbRLDM5K>; Tue, 4 Dec 2001 07:57:10 -0500
Date: Tue, 4 Dec 2001 07:48:15 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204074815.A12231@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204133932.A8805@caldera.de>; from hch@caldera.de on Tue, Dec 04, 2001 at 01:39:32PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@caldera.de>:
> There is no CML1 maintainer.  There are people maintaining the different
> tools intepreting CML1.  Some (e.g. the intree ones) are to ugly to consider,
> others are pretty nice.

I was referring to Michael Elizabeth Chastain, Keith Owens, and the other
people on the kbuild list who officially maintain the CML1 tools in the 
kernel tree.  The same people who took up my offer to attempt a better 
alternative to CML1 eighteen months ago.

And, by the way, there is no CML1 :-).  Instead, there are four
mutually incompatible dialects and a rulebase that breaks in different
ways depending on which interpreter you use.  Well, maybe just three
mutual incompatible dialects and one clone -- but it's notoriously
hard to verify that two interpreters have the same accept language, so
nobody knows for sure.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The state calls its own violence `law', but that of the individual `crime'"
	-- Max Stirner
