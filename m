Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbWHOT1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWHOT1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWHOT1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:27:11 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:24338 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S965231AbWHOT1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:27:10 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Mike Dresser <mdresser_l@windsormachine.com>
Subject: Re: Daily crashes, incorrect RAID behaviour
Date: Tue, 15 Aug 2006 20:27:09 +0100
User-Agent: KMail/1.9.4
Cc: Carsten Otto <carsten.otto@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com> <13e988610608150831u18ed0e85s50fe3a865548a865@mail.gmail.com> <Pine.LNX.4.64.0608151423200.25217@router.windsormachine.com>
In-Reply-To: <Pine.LNX.4.64.0608151423200.25217@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608152027.09880.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 19:28, Mike Dresser wrote:
> On Tue, 15 Aug 2006, Carsten Otto wrote:
> > Okay, after Ralf's message I found this newsgroup post:
> > http://groups.google.de/group/linux.debian.user/msg/f12dec920523a629?hl=d
> >e&
> >
> >> You should be aware that currently
> >> Maxtor Maxline III's(7v300F0's) do not work properly due to a firmware
> >> bug.  The current version shipping is VA111630, an update is available
> >> to VA111670 which merely reduces the frequency of timeouts that get the
> >> drive kicked out from the array.
>
> I'm running 680 now, and the 15 drives have been up for something like two
> months or so without issues at all.. Seems like the firmware fixes the
> problem.

Still, the RAID rebuild problem is worrying. I might have to deliberately 
fault my RAID5 partitions and see if they rebuild correctly..

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
