Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267896AbTBEKL3>; Wed, 5 Feb 2003 05:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267897AbTBEKL2>; Wed, 5 Feb 2003 05:11:28 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:55943 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267896AbTBEKL1>; Wed, 5 Feb 2003 05:11:27 -0500
Date: Wed, 5 Feb 2003 11:20:59 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre4-ac2 IDE status on PDC20268
Message-ID: <20030205102059.GG27959@louise.pinerecords.com>
References: <20030205063058.GA27959@louise.pinerecords.com> <200302050817.h158Hic14888@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302050817.h158Hic14888@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@redhat.com]
> 
> > but misdetects the max transfer rate of the only drive on the
> > secondary channel and then won't allow me to set UDMA > 2 on it
> > (I get no error msg but there's no change).
> 
> The 20268 code explicitly enforces that rule. I need to talk to Andre
> to find out exactly why. It is being done intentionally

Hmm, could you point me to the code in question?
I can't find it.  Thanks.

-- 
Tomas Szepe <szepe@pinerecords.com>
