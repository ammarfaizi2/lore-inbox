Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbSK2OIh>; Fri, 29 Nov 2002 09:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbSK2OIh>; Fri, 29 Nov 2002 09:08:37 -0500
Received: from guru.webcon.net ([66.11.168.140]:29649 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S267048AbSK2OIg>;
	Fri, 29 Nov 2002 09:08:36 -0500
Date: Fri, 29 Nov 2002 09:15:54 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alain Tesio <alain@onesite.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Asus P4B533 and resource conflict on IDE (P4PE also)
In-Reply-To: <1038581017.13625.18.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.50.0211290912480.24895-100000@light.webcon.net>
References: <20021129014416.54940079.alain@onesite.org> 
 <Pine.LNX.4.50.0211282256120.2289-100000@light.webcon.net>
 <1038581017.13625.18.camel@irongate.swansea.linux.org.uk>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2002, Alan Cox wrote:

> On Fri, 2002-11-29 at 04:09, Ian Morgan wrote:
> > The ICH4 IDE on my ASUS P4PE had the exact same problem, but the -ac pathes
> > make it hum along very nicely. Requring the PIIX driver, though, seems a
> > little wonky. Without -ac, the controller is detected as "ICH4" and doesn't
> > work. With the -ac patches, it works, but is detected as PIIX. Rather
> > confusing. Perhaps the the Configure.help should mention the ICH4?
> 
> Just a labelling difference. ICH4 is the chipset, it contains a PIIX IDE
> controller

Yes, I know that, but many people probably won't, was my point. Then again,
I guess anybody building their own kernel probably will have some clue about
what hardware is in their box, so it's probably not a big deal.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------
