Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261823AbRFBWLq>; Sat, 2 Jun 2001 18:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbRFBWLg>; Sat, 2 Jun 2001 18:11:36 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:51218 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261823AbRFBWL1>; Sat, 2 Jun 2001 18:11:27 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3B19646F.CBB6DB65@transmeta.com>
Date: Sat, 02 Jun 2001 15:10:55 -0700
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: missing sysrq
In-Reply-To: <Pine.LNX.4.10.10106011050380.2614-100000@coffee.psychology.mcmaster.ca> <20010601203841Z261493-933+3160@vger.kernel.org> <9f97hu$83v$1@cesium.transmeta.com> <20010602230815.A22390@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, Jun 01, 2001 at 04:13:02PM -0700, H. Peter Anvin wrote:
> > Let me guess... you're using a RedHat system?  RedHat, for some
> > idiotic reason, defaults to actively turning this off for you (and
> > they turn Stop-A off on SPARC, too.)
> 
> Umm, its off by default in 2.4.5 kernels, unless altered by a
> distributions boot scripts.
> 

That seems like a very bad idea.  What if there is a boot script bug?

	-hpa
