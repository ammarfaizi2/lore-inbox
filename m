Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbSK3Nf2>; Sat, 30 Nov 2002 08:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbSK3Nf2>; Sat, 30 Nov 2002 08:35:28 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:19487 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267243AbSK3Nf1>; Sat, 30 Nov 2002 08:35:27 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211301342.gAUDgkD15918@devserv.devel.redhat.com>
Subject: Re: hda: task_no_data_intr
To: john@grabjohn.com (John Bradford)
Date: Sat, 30 Nov 2002 08:42:46 -0500 (EST)
Cc: gzp@myhost.mynet (Gabor Z. Papp), alan@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200211301345.gAUDjoiZ000163@darkstar.example.net> from "John Bradford" at Nov 30, 2002 01:45:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: task_no_data_intr: error=0x04 { DriveStatusError }
> 
> I think that they are diagnostic messages that are a result of an old
> disk not supporting some new commands that are being send to it.  I

They are.

> thought this was done silently in the 2.4.x series - I see it on some
> really old, (100 MB) disks running 2.5.x

Some of them were not done on 2.4 before at all.

Alan
