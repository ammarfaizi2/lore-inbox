Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288940AbSANTCo>; Mon, 14 Jan 2002 14:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288862AbSANTBt>; Mon, 14 Jan 2002 14:01:49 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:6022
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288940AbSANTA0>; Mon, 14 Jan 2002 14:00:26 -0500
Date: Mon, 14 Jan 2002 13:44:26 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114134426.C17522@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Eli Carter <eli.carter@inet.com>,
	"Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020114132618.G14747@thyrsus.com> <E16QCL7-0002Xs-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16QCL7-0002Xs-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 14, 2002 at 07:00:13PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> The goal of a typical end user is "make it work, make it go away and do what
> it did last week". Random mechanics hating car owners don't do engine tuning
> jobs or fit turbochargers.

No...but they do change their own oil and antifreeze.  Upgrading your
kernel should be as simple as changing your oil.
 
> Secondly we've established we can pick the right CPU for the kernel reliably
> that is seperate to modules. 

Right, but that doesn't get you a recompiled binary with extended instructions
in it.

> Thirdly building a lot of stuff modular is the right choice anyway - in the
> world of hot plugging and USB Grandma is not going to want to recompile her
> kernel because she bought a new trackball to boost her quake score. 

I'm not arguing with building a lot of stuff modular.  The autoconfiugurator
does exactly that for hot-plug buses.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Are we to understand," asked the judge, "that you hold your own interests
above the interests of the public?"

"I hold that such a question can never arise except in a society of cannibals."
	-- Ayn Rand
