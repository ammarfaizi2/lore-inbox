Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310511AbSCCF7h>; Sun, 3 Mar 2002 00:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310509AbSCCF71>; Sun, 3 Mar 2002 00:59:27 -0500
Received: from dsl-64-34-35-93.telocity.com ([64.34.35.93]:11538 "EHLO
	roo.rogueind.com") by vger.kernel.org with ESMTP id <S293443AbSCCF7S>;
	Sun, 3 Mar 2002 00:59:18 -0500
Date: Sun, 3 Mar 2002 00:56:43 -0500 (EST)
From: Tom Diehl <tdiehl@rogueind.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invalid @home email addresses
In-Reply-To: <Pine.LNX.4.44.0203022258360.21225-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0203030052250.12119-100000@tigger.rogueind.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2002, Thomas Molina wrote:

> On 1 March 02 cox@home switched their services from infrastructure hosted 
> on hardware by Excite to "native" hardware.  All @home.com addresses are 
> now invalid.  Grepping through the source for these invalid addresses 
> produced the following:
> 
> drivers/net/de4x5.c 	mmporter@home.com
> drivers/scsi/megaraid.c 	johnsom@home.com
> drivers/scsi/ppa.h	johncavan@home.com 
> drivers/scsi/imm.h	johncavan@home.com 
> drivers/sound/aci.c	pellicci@home.com
> drivers/media/video/bttv-cards.c	daniel.herrington@home.com
> 
> Most addresses for home.com users simply switched to cox.net addresses.  

/s/cox.net/your_local_cable_provider.whatever.

> However, email to the above users at cox.net bounced in four out of five 
> cases.  I am posting here in hopes that theses users are still on the 
> mailing list and will respond.  If no response is received I would like to 
> submit a patch adding comments to the source code indicating the addresses 
> are no longer valid and no new email addresses are known.  

Cox cable switched to cox.net. Comcast switched to comcast.net and so forth.
Unless you know that persons local cable provider there is no way to know 
their new address without input from them or someone that knows them.

Excite was responsible for ALL of the @home addresses for the various
MSO's that had contracts with them.

HTH,

-- 
......Tom		CLUELESSNESS: There Are No Stupid Questions, But
tdiehl@rogueind.com	There Are LOTS of Inquisitive Idiots. :-)


