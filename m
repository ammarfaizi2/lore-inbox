Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTHFOuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTHFOuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:50:13 -0400
Received: from sea2-f7.sea2.hotmail.com ([207.68.165.7]:47889 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263398AbTHFOuK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:50:10 -0400
X-Originating-IP: [194.7.240.2]
X-Originating-Email: [lode_leroy@hotmail.com]
From: "lode leroy" <lode_leroy@hotmail.com>
To: felipe_alfaro@linuxmail.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 lockup while write()ing to /dev/hda1
Date: Wed, 06 Aug 2003 16:50:04 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F7aRjXHltO7WUH00028000@hotmail.com>
X-OriginalArrivalTime: 06 Aug 2003 14:50:05.0148 (UTC) FILETIME=[05C1E1C0:01C35C2A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, you're right... i don't see this on 2.6.0-test2 .
I should have tried upgrading first!


>From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
>To: lode leroy <lode_leroy@hotmail.com>
>CC: LKML <linux-kernel@vger.kernel.org>
>Subject: Re: 2.5.70 lockup while write()ing to /dev/hda1
>Date: Wed, 06 Aug 2003 15:05:06 +0200
>
>On Wed, 2003-08-06 at 14:32, lode leroy wrote:
> > I just want to report a problem I saw on linux 2.5.70:
> > (since I have a workaround, I do not intend to debug this further)
> >
> > the following program locks up the computer.
> > sometimes this has happened after about 16MB,
> > sometimes after about 64MB...
>
>Don't you think 2.5.70 is a little bit obsolete now? ;-)
>I recoomend you testing this on 2.6.0-test2-latest. Using the latest
>available kernel will probably help mantainers to nail down any problem.
>

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

