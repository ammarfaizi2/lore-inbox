Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbRAELiA>; Fri, 5 Jan 2001 06:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130168AbRAELhm>; Fri, 5 Jan 2001 06:37:42 -0500
Received: from server.cdi.cz ([194.213.254.2]:8976 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S129757AbRAELhf>;
	Fri, 5 Jan 2001 06:37:35 -0500
Posted-Date: Fri, 5 Jan 2001 12:37:23 +0100
Date: Fri, 5 Jan 2001 12:37:23 +0100 (CET)
From: Devik <devik@server.cdi.cz>
To: Mike <mike@khi.sdnpk.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-irda@pasta.cs.UiT.No" <linux-irda@pasta.cs.UiT.No>
Subject: Re: How can I create root disk in Redhat 6.0
In-Reply-To: <3A55AAF7.4F5EDFCD@khi.sdnpk.org>
Message-ID: <Pine.LNX.4.10.10101051234090.5989-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,
there are docs named HOWTO-????. There is also
one about boot/root disks.
I recommend you to boot from redhat instalation CD
and after launch pres Alt-F2 (or F3,4... a can't remember)
to get into free console with bash prompt.
Then mount your hacked(TM) disk and try to repair.
devik

> When i boot linux from rescue disk, i get following message:
> VFS: Insert root floppy disk to be loaded in RAM disk and press ENTER
> Now how can i create a root disk... I am trying to boot Redhat 6.0

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
