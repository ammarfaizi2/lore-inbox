Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbRCBMak>; Fri, 2 Mar 2001 07:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbRCBMaV>; Fri, 2 Mar 2001 07:30:21 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:27150 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129131AbRCBMaS>;
	Fri, 2 Mar 2001 07:30:18 -0500
Date: Fri, 02 Mar 2001 13:30:12 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: [2.4.2-ac5] X (4.0.1) crashes
To: linux-kernel@vger.kernel.org
Message-id: <3A9F9254.DA04EBD8@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote :

> Hi!
> 
> > > I use XFree86 4.0.1 with nvidia-drivers 0.96. 
> > 
> > Take it up with nvidia. Obfuscated effectively binary only code isnt anyone 
> > elses problem 

It is not only "effectively binary" but "actually binary".
There are no sources, only a few line of C "glue" code.

Maybe you are confusing it with the XFree86 nv drivers from xfree86.org ?
These are the nVidia drivers from nvidia.com
 
> Is it legal, BTW? Obfuscated drivers should _not_ be linked into
> kernel, because they are not "form preferable for editing".
> 
> <GPL>
> The source code for a work means the preferred form of the work for
> making modifications to it. For an executable work, complete source
> </GPL>
> 
> So nvidia drivers *are* binary only, as far as GPL is concerned. They
> should never be linked into kernel.
> 
> [Or, someone should get kernel with nvidia drivers compiled in from
> nvidia, and then ask them for sources :-)]
>                                                                    Pavel

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
