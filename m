Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269169AbRHFXSE>; Mon, 6 Aug 2001 19:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269168AbRHFXRo>; Mon, 6 Aug 2001 19:17:44 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:14980 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269165AbRHFXRm>; Mon, 6 Aug 2001 19:17:42 -0400
Date: Mon, 6 Aug 2001 17:17:54 -0600
Message-Id: <200108062317.f76NHsD25532@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getty problems
In-Reply-To: <9kn4ck$ovb$1@cesium.transmeta.com>
In-Reply-To: <20010806142703.A25428@lech.pse.pl>
	<20010806154530.A26776@lech.pse.pl>
	<20010807020944.A24146@weta.f00f.org>
	<20010806182414.A29605@lech.pse.pl>
	<9kn4ck$ovb$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Followup to:  <20010806182414.A29605@lech.pse.pl>
> By author:    Lech Szychowski <lech.szychowski@pse.pl>
> In newsgroup: linux.dev.kernel
> >
> > >     2.4.7-ac7:
> > >     ----------
> > [snip]
> > > 
> > > Are you use this kernel isn't devfs inflicted?
> > 
> > 2.4.7-ac7 is compiled without devfs, 2.4.5 has devfs support
> > compiled in but - IMHO - not used:
> 
> Yes, this is a known pathology of devfs.  It will do this to you even
> if it isn't used.

Would someone care to forward me the unsnipped bug report? I didn't
see the original message.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
