Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbRFNU7j>; Thu, 14 Jun 2001 16:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbRFNU73>; Thu, 14 Jun 2001 16:59:29 -0400
Received: from dweeb.lbl.gov ([128.3.1.28]:27911 "EHLO beeble.lbl.gov")
	by vger.kernel.org with ESMTP id <S261942AbRFNU7X>;
	Thu, 14 Jun 2001 16:59:23 -0400
Message-ID: <3B292578.1887366D@lbl.gov>
Date: Thu, 14 Jun 2001 13:58:32 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-RAID i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Guus Sliepen <guus@warande3094.warande.uu.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Looking for ifenslave.c
In-Reply-To: <20010613213012.A23439@sliepen.warande.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guus, there isn't a really official version of it..

At http://pdsf.nersc.gov/linux/ifenslave.c is the last version I
produced, that works with bonding in v2.2 and v2.4 kernels.

Please note; I'm currently bound up in DOE/LBNL contract issues, that
prevent any work on any GPL code on DOE/LBNL time.  Folks, don't flame
us - we know it, we are working on it.  (The problem actually dates back
to the 50's, when the labs where created!)  Once this contract issue is
cleared up, I've been given the 'Ok' to work on it again.

Which means, since I don't have anything at home to work on bonding
with, I can't officially support it.

Sorry.

thomas

Guus Sliepen wrote:
> 
> Hello,
> 
> The Ethernet bonding module is useless without ifenslave.c. I'm making a Debian
> package for it, and I have tried to find the "offical" distribution of this
> small program. I could not find an authorative source, instead a lot of copies
> and patched versions are scattered around the Internet (I maintain a patched
> version myself too).
> 
> I would like to combine all the useful extra features and patches into this
> Debian package, so if you know of a patched version or maintain one yourself,
> please send it to me.
> 
> Thanks,
> 
> --
> Met vriendelijke groet / with kind regards,
>   Guus Sliepen <guus@sliepen.warande.net>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
