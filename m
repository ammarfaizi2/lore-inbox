Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289362AbSAOCYK>; Mon, 14 Jan 2002 21:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289366AbSAOCX6>; Mon, 14 Jan 2002 21:23:58 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:13704
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289362AbSAOCXu>; Mon, 14 Jan 2002 21:23:50 -0500
Date: Mon, 14 Jan 2002 21:06:45 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rob Landley <landley@trommello.org>,
        Charles Cazabon <charlesc@discworld.dyndns.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114210645.H24120@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Rob Landley <landley@trommello.org>,
	Charles Cazabon <charlesc@discworld.dyndns.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Eli Carter <eli.carter@inet.com>,
	"Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>
In-Reply-To: <20020114173423.A23081@thyrsus.com> <E16QGUy-0003Kh-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16QGUy-0003Kh-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 14, 2002 at 11:26:40PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> I simply don't understand what you are trying to build and why it is hard.

Don't understand it?  Download it, follow the directions, and see.

It's not that hard.  Given Giacomo's table of probes it only took me about
two days to get it 85% of the way there.  The remaining 15% is partly 
issues with rulebase bugs that it exposes, and partly issues with what
to do about the possibility of ISA hardware that is not directly probeable.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

[W]hat country can preserve its liberties, if its rulers are not
warned from time to time that [the] people preserve the spirit of
resistance?  Let them take arms...The tree of liberty must be
refreshed from time to time, with the blood of patriots and tyrants.
	-- Thomas Jefferson, letter to Col. William S. Smith, 1787 
