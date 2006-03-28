Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWC1UGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWC1UGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWC1UGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:06:41 -0500
Received: from box.punkt.pl ([217.8.180.66]:61574 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S1751286AbWC1UGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:06:41 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: Rob Landley <rob@landley.net>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Tue, 28 Mar 2006 22:04:53 +0200
User-Agent: KMail/1.9.1
Cc: Avi Kivity <avi@argo.co.il>, Arjan van de Ven <arjan@infradead.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, nix@esperi.org.uk,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <442783E3.3050808@argo.co.il> <200603271448.56645.rob@landley.net>
In-Reply-To: <200603271448.56645.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603282204.53493.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 March 2006 21:48, Rob Landley wrote:
> Either way, it's not sounding like something I can grab and build uClibc
> systems with any time soon, the way I could use Mazur's headers to build
> uClibc.  I'll probably wind up using the gentoo headers when the 2.6.14
> version ships.

That's the trouble. While I have nothing against someone (as in -- not me :) 
doing all that abi separation, it's not something I can use straight away. 
Hell, I don't even get where in all of it I'd end up with something I could 
use (granted, I haven't looked into the thread too closely). Not to mention, 
that I suspect, that if there were enough people to do it, it would have 
gotten done two years ago.

So unless anybody's got a better idea, I'll try releasing some initial version 
of that llh-ng thingie rather soonish and see how that'll work out. Anybody 
with me on that? :)


-- 
Judge others by their intentions and yourself by your results.
                                                                 Guy Kawasaki
Education is an admirable thing, but it is well to remember from
time to time that nothing that is worth knowing can be taught.
                                                                  Oscar Wilde
