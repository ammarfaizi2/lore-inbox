Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285730AbSACFnS>; Thu, 3 Jan 2002 00:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286916AbSACFnI>; Thu, 3 Jan 2002 00:43:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17937 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285730AbSACFnC>;
	Thu, 3 Jan 2002 00:43:02 -0500
Message-ID: <3C33EF61.169E20AF@mandrakesoft.com>
Date: Thu, 03 Jan 2002 00:42:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@thyrsus.com>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102211038.C21788@thyrsus.com> <Pine.LNX.4.33.0201030327501.5131-100000@Appserv.suse.de> <3C33EC64.8E505D54@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Dave Jones wrote:
> >
> > o  Aunt Tilley.
> >    Vendors already ship an array of kernels which should make it
> >    unnecessary for her to have to build a kernel.
> >
> 
> There is a clear advantage to kernel developers in making things as
> easy as possible for Aunt Tilley to use our latest output.
> 
> If the difficulty of installing the latest kernel prevents her from
> doing that, she loses.  And so do we, because we don't get to know
> if we've fixed her problem.
> 
> If Eric can get the entire download-config-build-install process
> down to a single mouse click, he'll have done us all a great service.

OTOH if dumbing down the kernel config costs kernel developers
productivity and increases the noise-to-signal ratio on lkml, it's a
disservice...

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
