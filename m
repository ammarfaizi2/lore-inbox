Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbRDMQWA>; Fri, 13 Apr 2001 12:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131505AbRDMQVv>; Fri, 13 Apr 2001 12:21:51 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:9733 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131498AbRDMQVq> convert rfc822-to-8bit; Fri, 13 Apr 2001 12:21:46 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Andreas Peter <ujq7@rz.uni-karlsruhe.de>
To: linux-kernel@vger.kernel.org
Subject: Re: SW-RAID0 Performance problems
Date: Fri, 13 Apr 2001 18:28:58 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01041313473002.00533@debian> <20010413180152.A13740@unthought.net>
In-Reply-To: <20010413180152.A13740@unthought.net>
MIME-Version: 1.0
Message-Id: <01041318243302.00665@debian>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 13. April 2001 18:01 schrieb Jakob Østergaard:

> I can't say much about this... It looks like your setup is perfectly
> allright, and the performance *should* go up.   Instead it looks like you
> get a small performance drop from using the RAID.   Most odd.
>
> Do you have more controllers in the machine ? If so could you try to move
> eg. hdc to the second controller ?  The only thing I can imagine being the
> cause of the poor performance is, if your controller somehow doesn't handle
> both channels very well simultaneously.   It's far fetched, but it's the
> only suggestion I can think of.

The Board ist a Gigabyte 6BXDS (BX-Chipset) and 2 Celeron 533
I think the hardware is ok.

> I usually get a good speedup from using RAID-0 on 2.4.3 with IDE.  Both
> with two disks and with six.   This is with Intel PIIX4 and Promise 20262
> controllers.

Andreas
-- 
Andreas Peter *** ujq7@rz.uni-karlsruhe.de

