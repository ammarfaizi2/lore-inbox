Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317198AbSEXRdD>; Fri, 24 May 2002 13:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317202AbSEXRdC>; Fri, 24 May 2002 13:33:02 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:57771 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317198AbSEXRdC>; Fri, 24 May 2002 13:33:02 -0400
Date: Fri, 24 May 2002 19:32:48 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tobias Ringstrom <tori@ringstrom.mine.nu>,
        Myrddin Ambrosius <imipak@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux crypto?
In-Reply-To: <E17BGWd-0006S2-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.05.10205241932260.11037-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, Alan Cox wrote:

> > On Wed, 22 May 2002, Alan Cox wrote:
> > 
> > > What of it do you actually need in kernel space - encrypted file systems
> > > certainly ought to be there but are not very well handled in Linux proper
> > > right now - but anything else ?
> > 
> > IPsec.
> 
> At the moment there doesn't appear to be an IPsec stack we can merge however

what about freeswan - with some cleanups?

	tm

-- 
in some way i do, and in some way i don't.

