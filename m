Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWJVSNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWJVSNW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWJVSNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:13:21 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:15072 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1750779AbWJVSNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:13:20 -0400
Date: Sun, 22 Oct 2006 20:13:13 +0200
To: Michael Chan <mchan@broadcom.com>, Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: tg3 kernel bug in 2.6.18-mm3 and 2.6.19-rc2-mm2
Message-ID: <20061022181313.GB21463@gamma.logic.tuwien.ac.at>
References: <20061021132239.GA29288@gamma.logic.tuwien.ac.at> <20061021.123814.106436476.davem@davemloft.net> <20061021233610.f190e0a8.akpm@osdl.org> <20061021234107.GA12918@gamma.logic.tuwien.ac.at> <1551EAE59135BE47B544934E30FC4FC093FC5D@NT-IRVA-0751.brcm.ad.broadcom.com> <20061022162251.GA11663@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061022162251.GA11663@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Ok, you will lough at me...

On Son, 22 Okt 2006, preining wrote:
> > > 2.6.19-rc2	works
> > > 2.6.19-rc2+patch does not work
> > > 
> > It doesn't make any sense.  This patch is totally benign and
> > cannot cause the "No firmware running" and lockup that you
> > reported.  Can you please double-check?
> 
> Ok, I cannot reproduce it anymore. No idea why it happened.

And again I can reporduce it. How, (again, please don't lough):

I booted into windows (sometimes one has too, contract from the EC with
macros in Excel tables ... grrr).

WinXP didn't mange to get an IP address from my cable modem.

Rebooting into linux, same problem as reported, 

and, but no idea whether this is related: the modem just looses sync and
need several resets until it find back into syncronization.

I will do some more experiments with Win-different linux kernel
switching.

Sorry for the chaos, no idea what has happened here!!!

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>                    Università di Siena
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
`We've got to find out what people want from fire, how
they relate to it, what sort of image it has for them.'
The crowd were tense. They were expecting something
wonderful from Ford.
`Stick it up your nose,' he said.
`Which is precisely the sort of thing we need to know,'
insisted the girl, `Do people want fire that can be fitted
nasally?'
                 --- Ford "debating" what to do with fire with a marketing
                 --- girl.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
