Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291050AbSAaMu1>; Thu, 31 Jan 2002 07:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291051AbSAaMuT>; Thu, 31 Jan 2002 07:50:19 -0500
Received: from p3E9BFD09.dip.t-dialin.net ([62.155.253.9]:517 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S291050AbSAaMuD>;
	Thu, 31 Jan 2002 07:50:03 -0500
Date: Thu, 31 Jan 2002 13:45:33 +0100
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: linux-kernel@vger.kernel.org
Cc: mge@sistina.com
Subject: Re: [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020131134533.A10295@sistina.com>
Reply-To: mauelshagen@sistina.com
In-Reply-To: <20020130202254.A7364@fib011235813.fsnet.co.uk> <20020131010119.GB858@ufies.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020131010119.GB858@ufies.org>; from christophe.barbe.ml@online.fr on Wed, Jan 30, 2002 at 08:01:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:01:20PM -0500, christophe barbé wrote:
> On Wed, Jan 30, 2002 at 08:22:54PM +0000, Joe Thornber wrote:
> > The new kernel driver (known as "device-mapper") supports volume
> > management in general and is no longer Linux LVM specific.
> > As such it is a separate package from LVM2 which you will need
> > to download and install before building LVM2.
> > 
> >  ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper-beta1.tgz
> 
> I was so curious of the new license that could have been created by sistina
> that I try to download the driver but it seems not possible at this
> time.
> 
> So let me guess ... SPL2 ?
> Oh no, the sistina way, you want some free debugging before switching
> from GPL to SPL.

Thanks for these untenable guesses ;-)

LVM2 and the device-mapper are GPL/LGPL.

Sistina decided to offer this to the community and to keep it under
the FSF licenses.

This has been stated on the Linux LVM lists before.

OTOH we need to survive as a company and therefore will implement
comercial enhancements which will BTW enable us to do support and
further development of the above free software.

> 
> Christophe
> 
> -- 
> Christophe Barbé <christophe.barbe@ufies.org>
> GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E
> 
> As every cat owner knows, nobody owns a cat.
> --Ellen Perry Berkeley


Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
