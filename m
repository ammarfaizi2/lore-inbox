Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131046AbRAaIvD>; Wed, 31 Jan 2001 03:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131341AbRAaIux>; Wed, 31 Jan 2001 03:50:53 -0500
Received: from gate.mesa.nl ([194.151.5.70]:25874 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S131046AbRAaIur>;
	Wed, 31 Jan 2001 03:50:47 -0500
Date: Wed, 31 Jan 2001 09:50:13 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Matrox G450 problems with 2.4.0 and xfree
Message-ID: <20010131095013.B11375@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <20010130224354.A9917@joshua.mesa.nl> <Pine.LNX.4.30.0101310843260.6074-100000@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0101310843260.6074-100000@imladris.demon.co.uk>; from dwmw2@infradead.org on Wed, Jan 31, 2001 at 08:44:17AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 08:44:17AM +0000, David Woodhouse wrote:
> On Tue, 30 Jan 2001, Marcel J.E. Mol wrote:
> 
> > Installed a Matrox G450 on my linux system. Now it has problems
> > booting.
> > 
> > Previously I had a matrox G400 card and that worked without any problems.
> > 
> > Below follows .config for the 2.4.0 kernel.
> > 
> > # CONFIG_FB_MATROX_G450 is not set
> 
> --
> dwmw2

This is for dualhead support on G450. But anmyway i did try setting it and
it did not help.

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number, so they gave me a name!
                                -- Rupert Hine       http://www.ruperthine.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
