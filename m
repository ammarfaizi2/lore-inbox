Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311092AbSDDGnk>; Thu, 4 Apr 2002 01:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSDDGna>; Thu, 4 Apr 2002 01:43:30 -0500
Received: from khms.westfalen.de ([62.153.201.243]:28547 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S311092AbSDDGnZ>; Thu, 4 Apr 2002 01:43:25 -0500
Date: 04 Apr 2002 08:26:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8MC61VRHw-B@khms.westfalen.de>
In-Reply-To: <E16soms-0004Au-00@the-village.bc.nu>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox)  wrote on 03.04.02 in <E16soms-0004Au-00@the-village.bc.nu>:

> >  EXPORT_SYMBOL(vfree);
> >  EXPORT_SYMBOL(__vmalloc);
> > -EXPORT_SYMBOL_GPL(vmalloc_to_page);
> > +EXPORT_SYMBOL(vmalloc_to_page);
>
> The authors of that code made it GPL. You have no right to change that. Its
> exactly the same as someone taking all your code and making it binary only.
>
> You are
> 	-	subverting a digital rights management system
> 			[5 years jail in the USA]
> 	-	breaking a license
>
> but worse than that you are ignoring the basic moral rights of the authors
> of that code.

Frankly, I believe that it is both illegal (by the GPL) and morally  
bankrupt to add these "GPL only" symbols to the kernel *unless* you can  
get agreement for them fro *all* kernel copyright holders.

Which I predict you won't get.

That is, except when you handle the "_GPL" as a meaningless adornment.

MfG Kai
