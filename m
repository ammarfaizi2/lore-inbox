Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQJZQKl>; Thu, 26 Oct 2000 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129123AbQJZQKV>; Thu, 26 Oct 2000 12:10:21 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:9229
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129060AbQJZQKM>; Thu, 26 Oct 2000 12:10:12 -0400
Date: Thu, 26 Oct 2000 12:19:58 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Igmar Palsenberg <maillist@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID superblock
Message-ID: <20001026121958.A18594@animx.eu.org>
In-Reply-To: <20001025171255.26384.qmail@web6104.mail.yahoo.com> <Pine.LNX.4.21.0010261534490.9868-100000@server.serve.me.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.21.0010261534490.9868-100000@server.serve.me.nl>; from Igmar Palsenberg on Thu, Oct 26, 2000 at 03:35:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi,
> >  After I create a RAID setup on the drives,The
> > superblock will be generated at the end of the drives.
> > If I move these drives to other linux system, will
> > this
> >  system recognise the RAID setup without reconfiguring
> > the Linux ?
> 
> If the CHS / LBA settings are the same, and the kernel is the same : Yes.

While this subject is fresh, what would be wrong with using the entire drive
as opposed to creating a partition and adding the partition to the raid?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
