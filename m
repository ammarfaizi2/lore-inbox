Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282064AbRKVHb0>; Thu, 22 Nov 2001 02:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282067AbRKVHbQ>; Thu, 22 Nov 2001 02:31:16 -0500
Received: from gate.mesa.nl ([194.151.5.70]:44555 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S282064AbRKVHbD>;
	Thu, 22 Nov 2001 02:31:03 -0500
Date: Thu, 22 Nov 2001 08:30:50 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Dominik Kubla <kubla@sciobyte.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: New ac patch???
Message-ID: <20011122083050.B18888@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <20011121100849.D15851@joshua.mesa.nl> <E166TZh-0004T8-00@the-village.bc.nu> <20011121103354.E15851@joshua.mesa.nl> <20011121120033.C21032@duron.intern.kubla.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011121120033.C21032@duron.intern.kubla.de>; from kubla@sciobyte.de on Wed, Nov 21, 2001 at 12:00:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 12:00:33PM +0100, Dominik Kubla wrote:
> On Wed, Nov 21, 2001 at 10:33:54AM +0100, Marcel J.E. Mol wrote:
> > Not exaclty. It is a 48Gig drive in a dell inspiron 8000. I think it is
> > IBM but the logs do not show a brandname. I can try open up the case tonight
> > if you want to know for sure?
> 
> It's an IBM IC25T048ATDA05-0 to be precise.

Exact. But noone reports the 'IBM' part, not even hdparm -i...
But hdparm does shows that writecaching is enabled.

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
