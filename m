Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310299AbSCBDo7>; Fri, 1 Mar 2002 22:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310301AbSCBDou>; Fri, 1 Mar 2002 22:44:50 -0500
Received: from crusoe.degler.net ([66.114.64.229]:40198 "EHLO degler.net")
	by vger.kernel.org with ESMTP id <S310299AbSCBDod>;
	Fri, 1 Mar 2002 22:44:33 -0500
Date: Fri, 1 Mar 2002 22:43:52 -0500
From: Stephen Degler <sdegler@degler.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Dennis, Jim" <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Congrats Marcelo,
Message-ID: <20020301224352.B6570@crusoe.degler.net>
In-Reply-To: <2D0AFEFEE711D611923E009027D39F2B153AD4@cdserv.meridian-data.com> <Pine.LNX.4.21.0202281849450.2391-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0202281849450.2391-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Feb 28, 2002 at 06:52:25PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

FYI crypto is included in (Net|Free|Open)BSD source releases and I don't
believe it is an issue for them.

skd

On Thu, Feb 28, 2002 at 06:52:25PM -0300, Marcelo Tosatti wrote:
> 
> On Tue, 26 Feb 2002, Dennis, Jim wrote:
> 
> > Marcelo,
> > 
> >  Contratulations on your first "official" kernel release.  It seems to
> > have gone
> >  well (except for some complaints on slashdot about -rc4 SPARC patches
> > missing from
> >  the patch, but apparently in the full tarball).
> > 
> >  Now I need to know about the status of several unofficial patches:
> > 
> > 	XFS
> 
> Want to see stable in -ac first.
> 
> > 	LVM
> 
> Its on 2.4 already.
> 
> > 	i2c
> > 	Crypto
> > 	FreeS/WAN KLIPS
> > 	LIDS
> 
> I think its not possible to distribute crypto stuff in the stock kernel.
> 
> Am I wrong? 
> 
> > 	rmap
> 
> I need to see it running in production for more time.
> 
> >  Marcelo, there were some i2c updates included in the lmsensors package,
> > have they
> >  submitted those to you for integration into 2.4.19?
> 
> Nope. I could well integrate lm_sensors in the future.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
