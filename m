Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289037AbSANUiD>; Mon, 14 Jan 2002 15:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289013AbSANUgo>; Mon, 14 Jan 2002 15:36:44 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:37254
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288962AbSANUf1>; Mon, 14 Jan 2002 15:35:27 -0500
Date: Mon, 14 Jan 2002 15:19:42 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Charles Cazabon <linux@discworld.dyndns.org>
Cc: linux-kernel@vger.kernel.org, arjan@fenrus.demon.nl
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114151942.A20309@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Charles Cazabon <linux@discworld.dyndns.org>,
	linux-kernel@vger.kernel.org, arjan@fenrus.demon.nl
In-Reply-To: <20020114132618.G14747@thyrsus.com> <m16QCNJ-000OVeC@amadeus.home.nl> <20020114145035.E17522@thyrsus.com> <20020114142605.A4702@twoflower.internal.do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020114142605.A4702@twoflower.internal.do>; from linux@discworld.dyndns.org on Mon, Jan 14, 2002 at 02:26:05PM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Cazabon <linux@discworld.dyndns.org>:
> > "Crap." Melvin thinks.  "I don't remember what kind of network card I
> > compiled in.  Am I going to have to open this puppy up just to eyeball
> > the hardware?"
> 
> Uh, no.  Try `lsmod`.

He hard-compiled in that driver.  lsmod(1) can't see it.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

No one is bound to obey an unconstitutional law and no courts are bound
to enforce it.  	-- 16 Am. Jur. Sec. 177 late 2d, Sec 256
