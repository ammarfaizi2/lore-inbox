Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135216AbRDRQQU>; Wed, 18 Apr 2001 12:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135215AbRDRQQJ>; Wed, 18 Apr 2001 12:16:09 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:41222 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S133031AbRDRQPu>;
	Wed, 18 Apr 2001 12:15:50 -0400
Date: Wed, 18 Apr 2001 12:16:18 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Supplying missing entries for Configure.help -- corrections
Message-ID: <20010418121618.A22201@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
	axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010418110920.A21430@thyrsus.com> <E14puRP-00052X-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14puRP-00052X-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 18, 2001 at 05:04:25PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > Have you applied Steven Cole's version of my Configure.help patches
> > 1-5 yet?  If not, would you prefer to see further incremental patches
> 
> Steven has sent me a nice consolidated patch already..

OK.  Expect from me, then, a second patch that (a) cleans up three
duplicates I introduced, (b) removes dead symbols, and (c) puts explicit
delimiters on URLs and filenames in help text.  You should get this in
four or five hours max.

I'm resyncing with pre4 now.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

In every country and in every age, the priest has been hostile to
liberty. He is always in alliance with the despot, abetting his abuses
in return for protection to his own.
	-- Thomas Jefferson, 1814
