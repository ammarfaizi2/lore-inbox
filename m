Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270657AbRHJWJp>; Fri, 10 Aug 2001 18:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270665AbRHJWJf>; Fri, 10 Aug 2001 18:09:35 -0400
Received: from borg.org ([208.218.135.231]:25107 "HELO borg.org")
	by vger.kernel.org with SMTP id <S270657AbRHJWJU>;
	Fri, 10 Aug 2001 18:09:20 -0400
Date: Fri, 10 Aug 2001 18:09:31 -0400
From: Kent Borg <kentborg@borg.org>
To: Phil Kos <PhilK@solthree.com>
Cc: "'Horst von Brand'" <vonbrand@inf.utfsm.cl>, Marco Colombo <marco@esi.it>,
        Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org,
        kernelnewbies@nl.linux.org
Subject: Re: [ANNOUNCE] Vendor kernels unpakced
Message-ID: <20010810180931.C22004@borg.org>
In-Reply-To: <2167D6D1AACDD31196BE0008C7CF24DDAE0A18@issexc01.solthree.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <2167D6D1AACDD31196BE0008C7CF24DDAE0A18@issexc01.solthree.com>; from PhilK@solthree.com on Fri, Aug 10, 2001 at 12:29:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001 at 12:29:04PM -0700, Phil Kos wrote:
> > Just as it makes no sense to run a not-up-to-date release 
> > kernel, it makes
> > no sense to keep anything but the very last on line. Just MVHO.
> 
> I beg to differ, Herr Doktor von Brand. It makes more sense to run a
> not-up-to-date release kernel than it does to slavishly update to every new
> release without any pressing need for new features or functionality. 

Another reason to keep sources around: to know what is in a newer
kernel.

Right now I am wondering where I can find linuxppc_2_5 revision 1.442.
Not because I want to run it, but because I am told it was the basis
of a 2.4.2 kernel tree we have, and it would be useful in knowing what
changes are important as we try to move our work forward.  Over two
thousand files changed from official 2.4.2 to what we started
with--but I am guessing only a relatively small number of those
changes are important to us.  Getting a copy of that old kernel would
be useful in sorting it all out.


-kb, the Kent who would love to hear where he could get a copy of
linuxppc_2_5 revision 1.442.
