Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281568AbRKUJec>; Wed, 21 Nov 2001 04:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281565AbRKUJeW>; Wed, 21 Nov 2001 04:34:22 -0500
Received: from gate.mesa.nl ([194.151.5.70]:42249 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S281441AbRKUJeO>;
	Wed, 21 Nov 2001 04:34:14 -0500
Date: Wed, 21 Nov 2001 10:33:54 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: New ac patch???
Message-ID: <20011121103354.E15851@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <20011121100849.D15851@joshua.mesa.nl> <E166TZh-0004T8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E166TZh-0004T8-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 21, 2001 at 09:21:45AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 09:21:45AM +0000, Alan Cox wrote:
> > 2.4.13-ac will "flushing ide drives" on shutdown. This helped my laptop
> > from not '/dev/hdax no cleanly unmounted, checking' on startup. I'm sure
> > the system did not crash before that.
> 
> You have a box with an IBM 20Gig 2.5" drive (just out of interest)

Not exaclty. It is a 48Gig drive in a dell inspiron 8000. I think it is
IBM but the logs do not show a brandname. I can try open up the case tonight
if you want to know for sure?

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
