Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279113AbRLDQUe>; Tue, 4 Dec 2001 11:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278625AbRLDQUY>; Tue, 4 Dec 2001 11:20:24 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:436
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S279113AbRLDQUP>; Tue, 4 Dec 2001 11:20:15 -0500
Date: Tue, 4 Dec 2001 11:11:15 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204111115.A15160@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204142958.A14069@caldera.de>; from hch@caldera.de on Tue, Dec 04, 2001 at 02:29:58PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@caldera.de>:
> With mconfig [side-effect chasing] can be implemented easily [...]
> One toplevel config file can be implemented in CML1 easily,

You can spend all week telling us how easy it would be to implement
all the CML2 benefits that CML1 doesn't have, if you like -- but one
of the rules of this game is that an ounce of working code beats a
pound of handwaving.

When you've shown the list the bundle of CML1 implementation and 
rulesfile patches that brings CML1 up to snuff, *then* you'll have
grounds to argue that the switch to CML2 gains nothing.  

So don't talk about it, *do it*!  Whether you succeed or fail, one of
the two of us will get a valuable education from your attempt.  And
until you succeed or fail, arguing is just wasting everyone else's time.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Courage is resistance of fear, mastery of fear, not absence of fear.
