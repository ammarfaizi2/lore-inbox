Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283129AbRLDOo2>; Tue, 4 Dec 2001 09:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283630AbRLDOnN>; Tue, 4 Dec 2001 09:43:13 -0500
Received: from ns.caldera.de ([212.34.180.1]:26304 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S283135AbRLDMkC>;
	Tue, 4 Dec 2001 07:40:02 -0500
Date: Tue, 4 Dec 2001 13:39:32 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, Christoph Hellwig <hch@caldera.de>,
        Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204133932.A8805@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	"Eric S. Raymond" <esr@thyrsus.com>, Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204072808.A11867@thyrsus.com>; from esr@thyrsus.com on Tue, Dec 04, 2001 at 07:28:08AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 07:28:08AM -0500, Eric S. Raymond wrote:
> Christoph Hellwig <hch@caldera.de>:
> > On Mon, Dec 03, 2001 at 12:06:12PM +1100, Keith Owens wrote:
> > > The CML1 to CML2 conversion comes later, either in 2.5.3 or 2.5.4.
> > 
> > Is the CML2 merge actually agreed on?
> 
> Yes, unless Linus has changed his mind since March.  Which would be his
> privilege, of course -- but since the CML1 maintainers are unanimous that 
> CML1 is too kludgy to live and Linus knows that, it seems unlikely.

There is no CML1 maintainer.  There are people maintaining the different
tools intepreting CML1.  Some (e.g. the intree ones) are to ugly to consider,
others are pretty nice.


	Christoph (current maintainer of a CML1 intepreter)

-- 
Of course it doesn't work. We've performed a software upgrade.
