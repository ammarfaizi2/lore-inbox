Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUJHSrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUJHSrt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUJHSqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:46:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59863 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265768AbUJHSlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:41:24 -0400
Date: Fri, 8 Oct 2004 20:42:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Possible GPL Violation of Linux in Amstrad's E3 Videophone
Message-ID: <20041008184251.GA28790@elte.hu>
References: <35fb2e590410011509712b7d1@mail.gmail.com> <415DD1ED.6030101@drdos.com> <1096738439.25290.13.camel@localhost.localdomain> <41659748.9090906@drdos.com> <8B592DC4-18A9-11D9-ABEB-000393ACC76E@mac.com> <4165B265.2050506@drdos.com> <8550FDB8-18AC-11D9-ABEB-000393ACC76E@mac.com> <4165B53F.2060707@drdos.com> <20041008122703.GA15604@elte.hu> <Pine.GSO.4.61.0410082019100.12999@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0410082019100.12999@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.201, required 5.9,
	BAYES_00 -4.90, US_DOLLARS_3 0.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > all the politics aside, the Linux 2.6 kernel, if developed from scratch
> > as commercial software, takes at least this much effort under the
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
> > default COCOMO model:

> >  Total Estimated Cost to Develop                           = $ 175,974,824

> The biggest problem I have with counting `code size' (yes, we use
> sloccount at work), is that given more time and resources than needed
> to implement the required functionality, code size usually shrinks due
> to clean ups. So it costs _more_ money to decrease the #loc. Software
> is just like protocols design:

nowhere do i mean to imply that this figure represents the true value of
Linux, or that it even comes close. It is just a minimum lower bound i
cited.

I believe the true market value of Linux (the kernel alone) is probably
in the billions of dollars range and that there's one rather big and
agressive company on this planet that would be happy to pay even more
just to make it go away. (But for many of us Linux is like freedom (or
fresh air), with no particular dollar amount attached to it.)

	Ingo
