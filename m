Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSCNHi0>; Thu, 14 Mar 2002 02:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310910AbSCNHiP>; Thu, 14 Mar 2002 02:38:15 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64778
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311025AbSCNHiC>; Thu, 14 Mar 2002 02:38:02 -0500
Date: Wed, 13 Mar 2002 23:36:30 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Daniela Engert <dani@ngrt.de>, Shawn Starr <spstarr@sh0n.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin Dalecki <martin@dalecki.de>
Subject: Re: [patch] PIIX rewrite patch, pre-final
In-Reply-To: <20020314083038.A31923@ucw.cz>
Message-ID: <Pine.LNX.4.10.10203132334450.21396-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Vojtech Pavlik wrote:

> On Thu, Mar 14, 2002 at 08:24:02AM +0100, Daniela Engert wrote:
> > On Thu, 14 Mar 2002 07:52:58 +0100, Vojtech Pavlik wrote:
> > 
> > >> This will benifit PIIX3 chipsets? :)
> > >It should.
> > 
> > Are you aware of the batches of broken PIIX3 chips ?
> 
> I don't know of any IDE-related errata for the PIIX3 chip. At least
> Intel didn't publish any and there doesn't seem to be any workarounds in
> the original piix.c code, only a statement stating that the PIIX3 UDMA
> is broken, however, as far as I know, PIIX3 isn't UDMA capable at all.

27296302.pdf    82371SB (PIIX3) Timing Specification
29765804.pdf    INTEL 82371FB (PIIX) and 82371SB (PIIX3) SPECIFICATION UPDATE

Regards,

Andre

