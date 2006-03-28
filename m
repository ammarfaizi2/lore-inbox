Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWC1W6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWC1W6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWC1W6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:58:12 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:38569
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S964779AbWC1W6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:58:11 -0500
From: Rob Landley <rob@landley.net>
To: Mariusz Mazur <mmazur@kernel.pl>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Tue, 28 Mar 2006 17:57:48 -0500
User-Agent: KMail/1.8.3
Cc: Avi Kivity <avi@argo.co.il>, Arjan van de Ven <arjan@infradead.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, nix@esperi.org.uk,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <200603271448.56645.rob@landley.net> <200603282204.53493.mmazur@kernel.pl>
In-Reply-To: <200603282204.53493.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603281757.49255.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 March 2006 3:04 pm, Mariusz Mazur wrote:
> On Monday 27 March 2006 21:48, Rob Landley wrote:
> > Either way, it's not sounding like something I can grab and build uClibc
> > systems with any time soon, the way I could use Mazur's headers to build
> > uClibc.  I'll probably wind up using the gentoo headers when the 2.6.14
> > version ships.
>
> That's the trouble. While I have nothing against someone (as in -- not me
> :) doing all that abi separation, it's not something I can use straight
> away. Hell, I don't even get where in all of it I'd end up with something I
> could use (granted, I haven't looked into the thread too closely). Not to
> mention, that I suspect, that if there were enough people to do it, it
> would have gotten done two years ago.
>
> So unless anybody's got a better idea, I'll try releasing some initial
> version of that llh-ng thingie rather soonish and see how that'll work out.
> Anybody with me on that? :)

I'm highly interested in seeing the result. :)

Rob
-- 
Never bet against the cheap plastic solution.
