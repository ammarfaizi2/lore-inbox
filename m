Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281391AbRLDRTK>; Tue, 4 Dec 2001 12:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281484AbRLDRRw>; Tue, 4 Dec 2001 12:17:52 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:26804
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S281199AbRLDRQF>; Tue, 4 Dec 2001 12:16:05 -0500
Date: Tue, 4 Dec 2001 12:07:35 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Giacomo Catenazzi <cate@dplanet.ch>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204120735.C16578@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Giacomo Catenazzi <cate@dplanet.ch>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de> <19642.1007484062@redhat.com> <3C0CFF5F.3090404@dplanet.ch> <21945.1007485337@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <21945.1007485337@redhat.com>; from dwmw2@infradead.org on Tue, Dec 04, 2001 at 05:02:17PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> 
> cate@dplanet.ch said:
> >  I don't think esr changed non problematic rules, but one: all rules
> > without help become automatically dependent to CONFIG_EXPERIMENTAL. I
> > don't like it, but I understand why he makes this decision. 
> 
> That is precisely the kind of bogus change which should _not_ be done in 
> such an underhand way. 

Underhanded?  Hardly.  It was right there, with explanation, in one of the 
release announcements I've been posting.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

As war and government prove, insanity is the most contagious of
diseases.
	-- Edward Abbey
