Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264332AbTEPAoL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 20:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbTEPAoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 20:44:11 -0400
Received: from mailsrv.rollanet.org ([192.55.114.7]:402 "HELO mx.rollanet.org")
	by vger.kernel.org with SMTP id S264332AbTEPAoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 20:44:09 -0400
Subject: Re: [OpenAFS-devel] Re: Alternative to PAGs
From: Nathan Neulinger <nneul@umr.edu>
To: Garance A Drosihn <drosih@rpi.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
In-Reply-To: <p05210622bae9d966f847@[128.113.24.47]>
References: <Pine.LNX.4.44.0305150920400.1841-100000@home.transmeta.com>
	 <p05210622bae9d966f847@[128.113.24.47]>
Content-Type: text/plain
Organization: University of Missouri - Rolla
Message-Id: <1053046619.26151.21.camel@cessna.rollanet.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4.99 
Date: 15 May 2003 19:56:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I should probably also apologize to David here, because he's
> actually doing useful work.  Here I'm just butting in because it
> would be so great to see PAG support as part of linux, instead
> of something we have to keep sticking on the side of it.  RPI
> is moving our AFS cell to redhat linux servers, and the easier
> it is for openafs on linux, the nicer it will be for us.

I agree, having cleanly supported PAG support in the kernel would be
great. The problem is that we can't just "keep sticking on the side of
it". We'd be perfectly happy to do so - that's the way we do it on every
other unix platform that afs has EVER supported as far as I know.

The problem is that certain kernel developers have specifically and
intentionally (YES, intentionally, I've seen the discussions.) gone to
efforts to prevent the AFS developers from continuing to do this. We're
just looking for an alternative that allows AFS to continue to function
at all on newer kernels than 2.4.  

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216

