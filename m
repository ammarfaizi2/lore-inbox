Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUEOO7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUEOO7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUEOO7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:59:16 -0400
Received: from bay18-f48.bay18.hotmail.com ([65.54.187.98]:11019 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263093AbUEOO7D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:59:03 -0400
X-Originating-IP: [67.22.169.229]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Cc: apiszcz@solarrain.com
Subject: Re: Linux Kernel 2.6.6 IDE shutdown problems.
Date: Sat, 15 May 2004 14:59:01 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY18-F48cZi71mrvoG000268af@hotmail.com>
X-OriginalArrivalTime: 15 May 2004 14:59:01.0550 (UTC) FILETIME=[286194E0:01C43A8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext2 on this box


>From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
>To: "Justin Piszcz" <jpiszcz@hotmail.com>, linux-kernel@vger.kernel.org
>CC: apiszcz@solarrain.com
>Subject: Re: Linux Kernel 2.6.6 IDE shutdown problems.
>Date: Sat, 15 May 2004 15:06:20 +0200
>
>On Saturday 15 of May 2004 14:20, Justin Piszcz wrote:
> > The problem is the 2.6.6 kernel muxed my drive and when it fscked upon
> > reboot it deleted /etc/mtab and lilo.conf!
>
>What fs are you using?
>
> > Luckily I restored them from a backup and now run 2.6.5 and it is 
>working
> > fine.
> >
> > Linux 2.6.6 is a nightmare.
> >
> > I am looking into the benchmark problem with 2.6.6 now.
> >
> > --- In linux-kernel@yahoogroups.com, "Justin Piszcz" <jpiszcz@h...> 
>wrote:
> > >Now whenever I reboot it says input/output errors when it tries to 
>mount
> > >the drive? I will look into this further.
>
>This errors are HARMLESS and CAN'T corrupt your data.
>Please see http://bugme.osdl.org/show_bug.cgi?id=2672 for description+fix.
>
>Cheers,
>Bartlomiej
>

_________________________________________________________________
MSN Toolbar provides one-click access to Hotmail from any Web page – FREE 
download! http://toolbar.msn.click-url.com/go/onm00200413ave/direct/01/

