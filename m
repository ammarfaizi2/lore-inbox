Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261731AbSJCQlQ>; Thu, 3 Oct 2002 12:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSJCQlQ>; Thu, 3 Oct 2002 12:41:16 -0400
Received: from triton.neptune.on.ca ([205.233.176.2]:43666 "EHLO
	triton.neptune.on.ca") by vger.kernel.org with ESMTP
	id <S261731AbSJCQlP>; Thu, 3 Oct 2002 12:41:15 -0400
Date: Thu, 3 Oct 2002 12:46:48 -0400 (EDT)
From: Steve Mickeler <steve@neptune.ca>
X-X-Sender: steve@triton.neptune.on.ca
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: addressing > 128 scsi discs
In-Reply-To: <200210031638.g93Gc4804388@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0210031246240.1829-100000@triton.neptune.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do you have something that patches clean against 2.4.19-vanilla ?

On Thu, 3 Oct 2002, Pete Zaitcev wrote:

> > Is there a way in 2.4 to address more than 128 scsi discs ?
>
> Official major allocation allows 256. You can take a patch from
> a fresh Red Hat to do it.
>
> Also, you can use devfs or a combo of Kurt's scsi-many and scsidev.
>
> -- Pete
>



[-] Steve Mickeler [ steve@neptune.ca ]

[|] Todays root password is brought to you by /dev/random

[+] 1024D/9AA80CDF = 4103 9E35 2713 D432 924F  3C2E A7B9 A0FE 9AA8 0CDF

