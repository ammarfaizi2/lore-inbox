Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283294AbRLDSyK>; Tue, 4 Dec 2001 13:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283163AbRLDSwr>; Tue, 4 Dec 2001 13:52:47 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:60852
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283304AbRLDSv0>; Tue, 4 Dec 2001 13:51:26 -0500
Date: Tue, 4 Dec 2001 13:43:20 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Weinehall <tao@acc.umu.se>
Cc: =?iso-8859-1?Q?Ra=FAlN=FA=F1ez_de_Arenas_Coronado?= 
	<raul@viadomus.com>,
        linux-kernel@vger.kernel.org, matthias.andree@stud.uni-dortmund.de,
        hch@caldera.de, kaos@ocs.com.au, kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204134320.P16578@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Weinehall <tao@acc.umu.se>,
	=?iso-8859-1?Q?Ra=FAlN=FA=F1ez_de_Arenas_Coronado?= <raul@viadomus.com>,
	linux-kernel@vger.kernel.org, matthias.andree@stud.uni-dortmund.de,
	hch@caldera.de, kaos@ocs.com.au, kbuild-devel@lists.sourceforge.net,
	torvalds@transmeta.com
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com> <20011204194652.F360@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204194652.F360@khan.acc.umu.se>; from tao@acc.umu.se on Tue, Dec 04, 2001 at 07:46:52PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall <tao@acc.umu.se>:
> Yeah, let's lose the dependencies on perl, make, awk, sed, ld, ar,
> nm, strip, objcopy, objdump, depmod, grep, xargs, find, gzip,
> wish, tcl/tk and possibly others. That'd surely shave a lot of diskspace
> off my buildsystem. It's not like I use any of them for anything else...

I'm going to remove a few of these.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

You need only reflect that one of the best ways to get yourself a
reputation as a dangerous citizen these days is to go about repeating
the very phrases which our founding fathers used in the great struggle
for independence.	-- Attributed to Charles Austin Beard (1874-1948)
