Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUFIBBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUFIBBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 21:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265493AbUFIBBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 21:01:09 -0400
Received: from mail.dif.dk ([193.138.115.101]:933 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265492AbUFIBBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 21:01:05 -0400
Date: Wed, 9 Jun 2004 03:00:22 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: athul acharya <nyte2k@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dothan/Centrino cpufreq
In-Reply-To: <20040608224413.93994.qmail@web21004.mail.yahoo.com>
Message-ID: <Pine.LNX.4.56.0406090257360.25359@jjulnx.backbone.dif.dk>
References: <20040608224413.93994.qmail@web21004.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2004, athul acharya wrote:

> Hey folks,
>
> I noticed that 2.6.7-rc1 was supposed to have Dothan
> support for cpufreq, but since neither it nor -rc2
> worked  on my machine, I decided to take a look at the
> code and see if I couldn't figure something out.  I
> saw this:
>
[...]
> This worked, creating
> /sys/devices/system/cpu/cpu0/cpufreq/ and the whole
> shebang.  So, for whomever is in charge of cpufreq,
> the above change needs to be integrated in order for
> (some?) Dothans to work.
>

>From the MAINTAINERS file :

CPU FREQUENCY DRIVERS
P:      Dave Jones
M:      davej@codemonkey.org.uk
L:      cpufreq@www.linux.org.uk
W:      http://www.codemonkey.org.uk/projects/cpufreq/
S:      Maintained

So if you do not get any response to your initial mail I'd suggest mailing
the above address(es) (probably still CC linux-kernel) for this in the
future.

--
Jesper Juhl <juhl-lkml@dif.dk>

