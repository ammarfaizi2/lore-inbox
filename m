Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTIPMm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTIPMm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:42:29 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:11151 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261878AbTIPMm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:42:28 -0400
Date: Tue, 16 Sep 2003 14:41:54 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Olaf Hering <olh@suse.de>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "David S. Miller" <davem@redhat.com>, <mroos@linux.ee>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
In-Reply-To: <20030916121848.GA9897@suse.de>
Message-ID: <Pine.LNX.4.44.0309161437290.23442-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Sep 2003, Olaf Hering wrote:

>  On Tue, Sep 16, Benjamin Herrenschmidt wrote:
>
>
> > There are a few PPC machines for which atyfb is "critical":
>
> >  - Beige G3 (older XL iirc)
>
> this one works, but they use different chips.

Good. Rage II+ is also confirmed to work on PPC.

I'll have a patch for the iBook later today, as soon as I can confirm it
compiles.

Daniel

