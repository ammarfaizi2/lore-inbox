Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271707AbTHHRCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271710AbTHHRCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:02:53 -0400
Received: from mailrelay3.lanl.gov ([128.165.4.104]:46810 "EHLO
	mailrelay3.lanl.gov") by vger.kernel.org with ESMTP id S271707AbTHHRCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:02:52 -0400
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
From: Steven Cole <elenstev@mesatop.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jasper Spaans <jasper@vs19.net>,
       Linus Torvalds <torvalds@osdl.org>, andries.brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3020000.1060301062@[10.10.2.4]>
References: <20030807180032.GA16957@spaans.vs19.net>
	 <1060295842.3169.83.camel@dhcp22.swansea.linux.org.uk>
	 <3020000.1060301062@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1060361688.1967.9.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 08 Aug 2003 10:54:48 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-07 at 18:04, Martin J. Bligh wrote:
> --Alan Cox <alan@lxorguk.ukuu.org.uk> wrote (on Thursday, August 07, 2003 23:37:23 +0100):
> 
> > On Iau, 2003-08-07 at 19:00, Jasper Spaans wrote:
> >> It changes all occurrences of 'flavour' to 'flavor' in the complete tree;
> >> I've just comiled all affected files (that is, the config resulting from
> >> make allyesconfig minus already broken stuff) succesfully on i386.
> > 
> > The Linux kernel tended to favour european spelling, and favOUr is
> > indeed correct English.
> 
> Either way, haven't we stopped piddling around with spelling fixes and
> breaking everyone's patches yet? I thought we had ...
> 
> M.

Well, I for one have stopped with the spelling patches since the
cost/benefit ratio was too high for many key folks.  When the spelling
patches were being generated, we were quite careful not to "fix" English
spellings.

I won't begin the next round of spelling fixes until 2.7.40, for those
who want to plan ahead that far.  And next time, I'll send the patches
through the maintainers. But we can still argue about spelling fixes if
that makes people happier.

Cheers,
Steven (off-duty spelling cop)

