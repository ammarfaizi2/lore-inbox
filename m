Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270055AbRHGD4B>; Mon, 6 Aug 2001 23:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270057AbRHGDzw>; Mon, 6 Aug 2001 23:55:52 -0400
Received: from gear.torque.net ([204.138.244.1]:51729 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S270055AbRHGDzg>;
	Mon, 6 Aug 2001 23:55:36 -0400
Message-ID: <3B6F65C2.64BC3C1A@torque.net>
Date: Mon, 06 Aug 2001 23:51:30 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Heinz <mheinz@infiniconsys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Resources for SCSI, SRP, Infiniband?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Heinz <mheinz@infiniconsys.com> wrote:
> I'm tasked with developing a new SCSI driver for 2.4; 
> but I'm running into issues that (a) SCSI drivers 
> are different from other Linux device drivers and 
> (b) none of the SCSI driver docs/how-tos seem to have
> been updated since 2.0.x.

Strange, I'm pretty certain the linux documentation
project now includes my document:
  http://www.linuxdoc.org/HOWTO/SCSI-2.4-HOWTO
and has for the last 6 months.

> I'm making progress, but could someone direct me to 
> a list of do's and don't's for SCSI drivers in 2.4?

Have you looked at Eric Youngdales site:
  http://www.andante.org/scsi.html  ?

Alan Cox wrote an article about developing a SCSI driver
(but its a little out of date). Then there are the
maintainers of the existings scsi adapter drivers
who may lend you a hand. Best to address your general
scsi queries to the linux-scsi@vger.kernel.org

> Also, anybody else looking at developing IB and or SRP?

I went to an IB talk at the OLS and it seems that most
players don't want to say much; so much for open
software.

Doug Gilbert
