Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBTISW>; Tue, 20 Feb 2001 03:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129150AbRBTISL>; Tue, 20 Feb 2001 03:18:11 -0500
Received: from [202.212.27.177] ([202.212.27.177]:22538 "HELO antiopikon")
	by vger.kernel.org with SMTP id <S129108AbRBTISA>;
	Tue, 20 Feb 2001 03:18:00 -0500
Date: Tue, 20 Feb 2001 17:18:37 +0900
From: Augustin Vidovic <vido@ldh.org>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: eepro100.c, kernel 2.4.1
Message-ID: <20010220171837.A26967@ldh.org>
Reply-To: vido@ldh.org
In-Reply-To: <20010212133248.A7147@saw.sw.com.sg> <Pine.LNX.4.30.0102120048160.4687-100000@age.cs.columbia.edu> <20010220153048.A26551@ldh.org> <20010219232136.C26553@saw.sw.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010219232136.C26553@saw.sw.com.sg>; from saw@saw.sw.com.sg on Mon, Feb 19, 2001 at 11:21:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2001 at 11:21:36PM -0800, Andrey Savochkin wrote:
> On Tue, Feb 20, 2001 at 03:30:48PM +0900, Augustin Vidovic wrote:
> > On Mon, Feb 12, 2001 at 01:00:34AM -0800, Ion Badulescu wrote:
> > > > Augustin, could you send the output of `lspci' and `eepro100-diag -ee', please?
> > > > (The latter may be taken from ftp://scyld.com/pub/diag/)
> > > 
> > > I'd be curious to see them too.
> > 
> > Ok, here is the output (the status are displayed only if the interface
> > is down, so I had to go execute this manually on the machines) :
> > 
> > 
> > eepro100-diag.c:v2.02 7/19/2000 Donald Becker (becker@scyld.com)
> >  http://www.scyld.com/diag/index.html
> > Index #1: Found a Intel i82557 (or i82558) EtherExpressPro100B adapter at 0xef00.
> [snip]
> 
> What about lspci?

Ah, yes, here it is :

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:0c.0 Ethernet controller: Intel Corporation 82557 (rev 08)
00:0d.0 Ethernet controller: Intel Corporation 82557 (rev 08)
00:0e.0 VGA compatible controller: ATI Technologies Inc 215GP [Mach64 GP] (rev 5c)

