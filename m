Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283269AbRLDSsA>; Tue, 4 Dec 2001 13:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283266AbRLDSqY>; Tue, 4 Dec 2001 13:46:24 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:57012
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283269AbRLDSo7>; Tue, 4 Dec 2001 13:44:59 -0500
Date: Tue, 4 Dec 2001 13:36:29 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: raul@viadomus.com, linux-kernel@vger.kernel.org,
        matthias.andree@stud.uni-dortmund.de, hch@caldera.de, kaos@ocs.com.au,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204133629.M16578@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Tom Rini <trini@kernel.crashing.org>, raul@viadomus.com,
	linux-kernel@vger.kernel.org, matthias.andree@stud.uni-dortmund.de,
	hch@caldera.de, kaos@ocs.com.au, kbuild-devel@lists.sourceforge.net,
	torvalds@transmeta.com
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com> <20011204182236.GM17651@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204182236.GM17651@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Tue, Dec 04, 2001 at 11:22:36AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org>:
> >     Maybe for you. For me it *is* an issue. I don't like more and
> > more dependencies for the kernel. I mean, if I can drop kbuild and
> > keep on building the kernel with the old good 'make config' I won't
> > worry, but otherwise I don't think that kernel building depends on
> > something like Python.
> 
> One of the things that I _think_ is happening is that lots of other
> scripts/ files are being redone, and thus removing them from the list,
> so in effect we're trading out one or two for just Python.

That is my intention.

> The right tools for the right job.  C is good for the kernel.  Python is
> good at manipulating strings.

*Perl* is good at strings.  Python is good at actual data structures :-).
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The people of the various provinces are strictly forbidden to have in their
possession any swords, short swords, bows, spears, firearms, or other types
of arms. The possession of unnecessary implements makes difficult the
collection of taxes and dues and tends to foment uprisings.
        -- Toyotomi Hideyoshi, dictator of Japan, August 1588
