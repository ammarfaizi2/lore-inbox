Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRALXm4>; Fri, 12 Jan 2001 18:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129957AbRALXmr>; Fri, 12 Jan 2001 18:42:47 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45829 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129903AbRALXma>; Fri, 12 Jan 2001 18:42:30 -0500
Subject: Re: ide.2.4.1-p3.01112001.patch
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Fri, 12 Jan 2001 23:43:23 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010112204626.A2740@suse.cz> from "Vojtech Pavlik" at Jan 12, 2001 08:46:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HDqv-0005Fm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to hear about such reports so that I can start debugging (and
> perhaps get me one of those failing boards, they must be quite cheap
> these days).

This is one of the most precise reports I have

|The system is an AMD K6-3 on a FIC PA-2013 mobo with 3 IDE disks.  The
|size of hda is 4.3 GB, the size of hdb is 854 MB and the size of hdc is
|1.2 GB.  Hdd is an IDE CDROM drive

I think its significant that two reports I have are FIC PA-2013 but not all.
What combination of chips is on the 2013 ?

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
