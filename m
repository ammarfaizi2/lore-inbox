Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbREaUsp>; Thu, 31 May 2001 16:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbREaUsf>; Thu, 31 May 2001 16:48:35 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:32522 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S263232AbREaUsZ>;
	Thu, 31 May 2001 16:48:25 -0400
Date: Thu, 31 May 2001 16:50:34 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Configure.help is complete
Message-ID: <20010531165034.A10573@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.1.20010531130356.00aaba18@sandbox.jaggnet.org> <3B16ACBC.E9BB936F@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B16ACBC.E9BB936F@redhat.com>; from arjanv@redhat.com on Thu, May 31, 2001 at 09:42:36PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com>:
> > Linux Kernel v2.4.5-ac5 Configuration
> > CML1
> > 
> > Bottom of IDE, ATA and ATAPI Block devices;
> > 
> > < > Support Promise software RAID (NEW)   -> Help
> > There is no help available for this kernel option.
> 
> How about
> "Say "Y" or "M" if you have a Promise Fasttrak (tm) Raid controller
> and want linux to use the softwarraid feature of this card.
> This driver uses /dev/ataraid/dXpY (X and Y numbers) as device names.
> 
> If you have a Promise Fasttrak(tm) card but do not use the BIOS provided
> raid feature, say "N".

Um, tell me what the symbol name and prompt for this is, please?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

[President Clinton] boasts about 186,000 people denied firearms under
the Brady Law rules.  The Brady Law has been in force for three years.  In
that time, they have prosecuted seven people and put three of them in
prison.  You know, the President has entertained more felons than that at
fundraising coffees in the White House, for Pete's sake."
	-- Charlton Heston, FOX News Sunday, 18 May 1997
