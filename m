Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbTFWWQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265420AbTFWWQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:16:15 -0400
Received: from cmsrelay02.mx.net ([165.212.11.111]:32996 "HELO
	cmsrelay02.mx.net") by vger.kernel.org with SMTP id S265394AbTFWWPJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:15:09 -0400
X-USANET-Auth: 165.212.8.11    AUTO bradtilley@usa.net uwdvg001.cms.usa.net
Date: Mon, 23 Jun 2003 18:29:13 -0400
From: Brad Tilley <bradtilley@usa.net>
To: <root@mauve.demon.co.uk>, "Brad Tilley" <bradtilley@usa.net>
Subject: Re: [Re: OS Fails to Load]
CC: <linux-kernel@vger.kernel.org>
X-Mailer: USANET web-mailer (CM.0402.5.6)
Mime-Version: 1.0
Message-ID: <098HFwwdN8704S01.1056407353@uwdvg001.cms.usa.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it's the monkeys crawling out of the drives ;)... I mean that it hangs at
that point in the loading process and does not go any further. For example,
once the machine arrives at 'Mounting Local Filesystems' it hangs (proceeds no
further) and requires a power cycle. Is that clear enough?

root@mauve.demon.co.uk wrote:
> > 
> > Hello,
> > 
> > 50% of the time when I boot RH Linux 9 (2.4.20-18.9) the OS fails to load.
The
> > failure usually occurs during a period of intense disk activity such as
> > 'finding module dependencies' or 'mounting local filesystems'. I can
reproduce
> > this error with the most recent RH kernel and the kernel that the distro
> > originally shipped with and 2.4.21 from Kernel.org built using RH's
config
> > files. Usually after 4-5 power cycles, the OS loads OK and the machine
runs
> > fine once it gets going.
> 
> Fails? 
> Monkeys flying out of the disk drive, an oops, ...?
> 
> 



