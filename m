Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbTH3RL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 13:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTH3RLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 13:11:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:48830 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261815AbTH3RLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 13:11:14 -0400
Date: Sat, 30 Aug 2003 14:06:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Dave Bentham <dave.bentham@ntlworld.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre2
Message-ID: <Pine.LNX.4.55L.0308301401560.31588@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Last Wednesday I posted here that when mounting /dev/scd0 CDROM
> (hdd=ide-scsi) the new kernel 2.4.22 panicked as 2.4.21 did before that.
> 2.4.20 is fine in this regard. If I remove the 'hdd=ide-scsi' appendage
> then my CD is fine.

Can you please show us all the boot messages before panic?

> Someone has also reported his SCSI Megaraid killed the 2.4.22 too,
> looking a similar, if not the same, issue.

I've seen the report but havent looked into it in detail. Will do so now.

> So far there's been no response.

> It looked to me (a layman as far as the kernel software is concerned)
> that email's after the 2.4.21 SCSI problem were posted and that the
> issue was being looked at and even perhaps fixed. Is it believed to have
> been fixed in 2.4.22 (i.e. I've not built my kernel properly) or is it
> still a known problem?

I didnt knew of this problem. Please show the boot messages before panic.
Also identifying which 2.4.21-pre started the problems is helpful.
