Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281781AbRKUMYH>; Wed, 21 Nov 2001 07:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281766AbRKUMX6>; Wed, 21 Nov 2001 07:23:58 -0500
Received: from gate.mesa.nl ([194.151.5.70]:11018 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S281775AbRKUMXu>;
	Wed, 21 Nov 2001 07:23:50 -0500
Date: Wed, 21 Nov 2001 13:23:33 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dominik Kubla <kubla@sciobyte.de>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org,
        andre@linux-ide.org
Subject: Re: New ac patch???
Message-ID: <20011121132333.F15851@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <20011121120033.C21032@duron.intern.kubla.de> <E166VIr-0004ik-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E166VIr-0004ik-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 21, 2001 at 11:12:28AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 11:12:28AM +0000, Alan Cox wrote:
> > > Not exaclty. It is a 48Gig drive in a dell inspiron 8000. I think it is
> > > IBM but the logs do not show a brandname. I can try open up the case tonight
> > > if you want to know for sure?
> > 
> > It's an IBM IC25T048ATDA05-0 to be precise.
> 
> Thanks. It seems IBM laptop drives are the ones that specifically need this
> fix. That ties in with the windows 98 reports/microsoft fixes.

Would that be enough reason to add only the specific flushing code of
the taskfile patch (if at all possible) to the kernel? Maybe Andre is
willing to extract the relevant code in a seperate patch...

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
