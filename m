Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283163AbRLMCxv>; Wed, 12 Dec 2001 21:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283204AbRLMCxl>; Wed, 12 Dec 2001 21:53:41 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:42193 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S283163AbRLMCx1>; Wed, 12 Dec 2001 21:53:27 -0500
Subject: Re: Unknown bridge resource
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.30.0112130004310.5686-100000@balu>
In-Reply-To: <Pine.GSO.4.30.0112130004310.5686-100000@balu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 13 Dec 2001 03:52:48 +0100
Message-Id: <1008211968.16830.1.camel@nc1701d>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the pci id is not found (see drivers/pci/pci.ids), you'll get this
message. If you can supply the description, the maintainer is Martin
Mares <mj@ucw.cz>, see also http://pciids.sf.net/.

On Thu, 2001-12-13 at 00:08, Pozsar Balazs wrote:
> 
> Hi all,
> 
> During boot, i got these two lines in dmesg:
> Unknown bridge resource 0: assuming transparent
> Unknown bridge resource 2: assuming transparent
> 
> What do they mean?
> 
> 
> ps: I noticed these because they are written on the console even if quiet
> mode is on. There was a patch for 2.4-ac, but it seems that it somehow
> lost... :(
> 
> -- 
> Balazs Pozsar
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Juergen Sawinski
Max-Planck-Institute for Medical Research
Dept. of Biomedical Optics
Jahnstr. 29
D-69120 Heidelberg
Germany

Phone:  +49-6221-486-309
Fax:    +49-6221-486-325

priv.
Phone:  +49-6221-418 848
Mobile: +49-171-532 5302

