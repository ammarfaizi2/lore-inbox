Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135963AbRDTQ0p>; Fri, 20 Apr 2001 12:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135964AbRDTQ0f>; Fri, 20 Apr 2001 12:26:35 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:8683 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S135963AbRDTQ0a>;
	Fri, 20 Apr 2001 12:26:30 -0400
Message-ID: <3AE0632E.61B20C0A@mandrakesoft.com>
Date: Fri, 20 Apr 2001 12:26:22 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob McElrath <rsmcelrath@students.wisc.edu>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone 
 paying attention?
In-Reply-To: <20010420101951.A6011@thyrsus.com> <E14qc9E-0001PW-00@the-village.bc.nu> <20010420105934.A6668@thyrsus.com> <20010420085148.V13403@opus.bloom.county> <3AE05E7C.F9C76ED2@mandrakesoft.com> <20010420111512.H22687@draal.physics.wisc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob McElrath wrote:
> 
> Jeff Garzik [jgarzik@mandrakesoft.com] wrote:
> > Tom Rini wrote:
> > > Which does boil down to having to work with trees other than Linus or
> > > Alans.  Remember, the official tree is not always the up-to-date tree,
> > > or in the case of other arches, the most relevant tree.
> >
> > Yep.  You could even look at Linus as simply the x86 port maintainer :)
> >
> > Except for alpha and x86, AFAIK, most people wind up going through
> > arch-specific channels to get their kernels...
> 
> This may be a dumb question, but is there some place where the arch
> maintainers are listed?  Where the arch-specific trees are kept?  Where
> would I go to get the latest set of relevant patches for alpha?

As I noted in the e-mail to which you replied, there is no separate
alpha tree nor arch-specific channel for alpha kernels.  Generally fixes
to the Alpha tree appear quickly and get merged quickly, and the tree
stays in sync quite well.  Watch linux-kernel or Alan Cox's patchkit for
Alpha fixes that may be in transmit to Linus.

There are of course RedHat's alpha distro, and various mailing lists on
http://www.alphalinux.org/

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
