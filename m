Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318162AbSIOS3m>; Sun, 15 Sep 2002 14:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318165AbSIOS3m>; Sun, 15 Sep 2002 14:29:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56592 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318162AbSIOS3m>;
	Sun, 15 Sep 2002 14:29:42 -0400
Message-ID: <3D84D29D.5090604@mandrakesoft.com>
Date: Sun, 15 Sep 2002 14:34:05 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Daniel Phillips <phillips@arcor.de>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
References: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com> <E17qRfU-0001qz-00@starship> <20020915020739.A22101@devserv.devel.redhat.com> <E17qalv-0000B6-00@starship> <20020915142304.A21363@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> This has nothing to do with a debugger, this is a different topic.
> You actually want a crash dump analyzis tool, and so do I.
> So, let's discuss that. I happen to get e-mails with oops in USB
> callbacks pretty often, and they are always useless. It would be
> possible to track them if off-stack memory was saved, perhaps.
> However, to expect users to use debugger to collect this off-stack
> information is a delusion.


http://lkcd.sourceforge.net/

Linux crash dumps, and includes an analysis tool...


