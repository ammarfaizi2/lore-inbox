Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262361AbRENSYc>; Mon, 14 May 2001 14:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262367AbRENSYW>; Mon, 14 May 2001 14:24:22 -0400
Received: from ns1.SuSE.com ([202.58.118.2]:37136 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S262361AbRENSYK>;
	Mon, 14 May 2001 14:24:10 -0400
Date: Mon, 14 May 2001 11:24:07 -0700
From: Mads Martin =?iso-8859-1?Q?J=F8rgensen?= <mmj@suse.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>
Subject: Re: PATCH 2.4.4.ac8: Tulip net driver fixes
Message-ID: <20010514112407.E781@suse.com>
In-Reply-To: <3AFD8E2E.302F1AB5@mandrakesoft.com> <20010514112216.A25436@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010514112216.A25436@lucon.org>; from hjl@lucon.org on Mon, May 14, 2001 at 11:22:16AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* H . J . Lu <hjl@lucon.org> [May 14. 2001 11:22]:
> On Sat, May 12, 2001 at 03:25:34PM -0400, Jeff Garzik wrote:
> > Attached is a patch against 2.4.4-ac8 which includes several fixes to
> > the Tulip driver.  This should fix the reported PNIC problems, as well
> > as problems with forcing media on MII phys and several other bugs.
> 
> Your patch doesn't apply to 2.4.4-ac8 cleanly:

No, I noticed that too. But the 1.1.6 from
http://sourceforge.net/projects/tulip/ works fine here.

-- 
Mads Martin Joergensen, http://mmj.dk
"Why make things difficult, when it is possible to make them cryptic and
totally illogic, with just a little bit more effort."
                                -- A. P. J.
