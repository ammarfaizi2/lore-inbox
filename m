Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280831AbRKBVEc>; Fri, 2 Nov 2001 16:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280833AbRKBVEW>; Fri, 2 Nov 2001 16:04:22 -0500
Received: from host213-121-105-27.in-addr.btopenworld.com ([213.121.105.27]:711
	"HELO mail.dark.lan") by vger.kernel.org with SMTP
	id <S280831AbRKBVEM>; Fri, 2 Nov 2001 16:04:12 -0500
Subject: Re: [OT] Intel chipset development documents
From: Greg Sheard <greg@ecsc.co.uk>
To: Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011102183829.A31651@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1004721050.20610.7.camel@lemsip> 
	<20011102183829.A31651@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.02.08.57 (Preview Release)
Date: 02 Nov 2001 21:03:43 +0000
Message-Id: <1004735023.21120.12.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-02 at 17:38, Martin Mares wrote:
> Hello!
> 
> > Hi all. Apologies for OT, but this seems the best place to ask.
> > Intel have removed documentation for the 430VX (Triton) chipset from
> > their developer site. I'm trying to check that the access details for
> > the Southbridge are the same as for the 440BX chipset, since I'm working
> > on some code for direct PCI access. If they're not, could somebody
> > please let me have the relevant documentation?
> 
> I guess I could have some 430VX documentation at home (will check
> tomorrow).
> 
> As far as I remember, Configuration Type 1 should be supported since
> the earliest Intel chipset, Type 2 could vary.
> 

Thanks for that Martin, much appreciated.

I already have the configuration type down (it's 1), but the 430VX and
also the VIA 585 seem only to report host bridges. I'm unable to spot
the piece of code which does different PCI-related things for these
chipsets in the kernel. Does anybody know if a workaround is applied?

Regards,
Greg.

