Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132434AbRDNAIa>; Fri, 13 Apr 2001 20:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132465AbRDNAIU>; Fri, 13 Apr 2001 20:08:20 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:3516 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S132434AbRDNAIM>;
	Fri, 13 Apr 2001 20:08:12 -0400
Message-ID: <3AD794E2.22B55FE6@mandrakesoft.com>
Date: Fri, 13 Apr 2001 20:08:02 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-17mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: 2.5 and beyond (was Re: New SYM53C8XX driver in 2.4.3-ac5 FIXES CD 
 Writing!!!!)
In-Reply-To: <E14oDFI-0003or-00@the-village.bc.nu> <E14oDW7-0002y9-00@zion.int.anathoth.gen.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Grant wrote:
> Linus,
> 
> Can't we have a controlled  development tree branch for 2-3 months just to get
> the ReiserFS/LVM/quota/knfsd integration done _cleanly_ (this has significant
> short-term  benefits NOW), with the brakes on all other changes, and another
> development tree where everyone goes wild with NUMA/Networking et al., where
> the changes from the other get merged???

We have -got- to get 2.4 stable and sane first.  It's a psychological
thing, but if Linus opens 2.5 now, people will ignore the existing 2.4
problems that need attention.

If LVM et. al. is fundamentally broken in 2.4, then mark it experimental
and support it via external patches.  That's the way these things are
always dealt it, when you need a feature set beyond the existing stable
kernel.

Patience, grasshopper :)

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
