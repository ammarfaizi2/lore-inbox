Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264446AbRFIJSD>; Sat, 9 Jun 2001 05:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264449AbRFIJRx>; Sat, 9 Jun 2001 05:17:53 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:36760 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264446AbRFIJRq>; Sat, 9 Jun 2001 05:17:46 -0400
Date: Sat, 9 Jun 2001 10:17:43 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@yellow.csi.cam.ac.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
In-Reply-To: <9fskv3$niq$1@cesium.transmeta.com>
Message-ID: <Pine.SOL.4.33.0106091015470.572-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jun 2001, H. Peter Anvin wrote:
> Followup to:  <200106090352.f593q7M491225@saturn.cs.uml.edu>
> By author:    "Albert D. Cahalan" <acahalan@cs.uml.edu>
> In newsgroup: linux.dev.kernel
> > >
> > > But in spite of all this, you're not really measure the critical
> > > temperature, which is junction tempature.  Yes, case tempature has *some*
> >
> > There are processors with temperature measurement built right
> > into the silicon.
>
> As far as I know, ALL current microprocessors do.

The current x86 setup uses a small sensor sitting under the CPU socket.
Intel's more recent output does have a heat sensor of its own, for thermal
protection purposes - presumably this is exported to the chipset - but
older ones don't appear to...


James.

