Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbRADWSZ>; Thu, 4 Jan 2001 17:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130407AbRADWSP>; Thu, 4 Jan 2001 17:18:15 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:56859 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129183AbRADWSC>; Thu, 4 Jan 2001 17:18:02 -0500
Date: Fri, 5 Jan 2001 00:25:09 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
cc: Sven Koch <haegar@cut.de>,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: RE: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <4461B4112BDB2A4FB5635DE1995874320223BC@mail0.myrio.com>
Message-ID: <Pine.LNX.4.21.0101050019530.4273-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Torrey Hoffman wrote:

> I had exactly this problem with the Maxtor 61 GB drive on my 
> Pentium based server.  Theoretically a BIOS upgrade could fix it,
> but ASUS quit making BIOS upgrades for my motherboard two years
> ago.

Ah well, join the club in my case :)

> I solved the problem by getting a Promise Ultra 100 controller
> and putting the drive on that. Works perfectly under Linux 
> Mandrake 2.2.17-mdk-21 - it shows up as /dev/hde.  They are
> cheap controllers if you don't get the RAID version.

Thanx.. Will try that. New machine costs more.
 
> Best wishes.
> 
> Torrey Hoffman


	Regards,

		Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
