Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280637AbRKNPSk>; Wed, 14 Nov 2001 10:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280635AbRKNPSb>; Wed, 14 Nov 2001 10:18:31 -0500
Received: from gate.mesa.nl ([194.151.5.70]:23565 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S280634AbRKNPSY>;
	Wed, 14 Nov 2001 10:18:24 -0500
Date: Wed, 14 Nov 2001 16:18:18 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]Disk IO statistics for all disks (request queue)
Message-ID: <20011114161818.C23345@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <20011114092022.A23345@joshua.mesa.nl> <HBEHIIBBKKNOBLMPKCBBIEGGEBAA.znmeb@aracnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBIEGGEBAA.znmeb@aracnet.com>; from znmeb@aracnet.com on Wed, Nov 14, 2001 at 06:59:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 06:59:35AM -0800, M. Edward Borasky wrote:
> Where might I find the Stephan Tweedie patches?

	ftp.uk.linux.org:/pub/linux/sct/fs/profiling/ 

contains the sard code (although it seems a bit outdated). RedHat
also includes it in thein kernel, so SRPM might have an up to date
patch for it.

-Marcel
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > Sent: Wednesday, November 14, 2001 12:20 AM
> > Subject: Re: [PATCH]Disk IO statistics for all disks (request queue)
> >
> > Hi,
> >
> > What is wrong with tha sar patches from Stephan Tweedie.
> > They also include data to caclculate disk responsetime, busy%
> > and queue lengths.
> > Would be nice to have this in the mainstream kernel.
> >
> > -Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
