Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289680AbSAOV1k>; Tue, 15 Jan 2002 16:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289686AbSAOV1a>; Tue, 15 Jan 2002 16:27:30 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:42766 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S289680AbSAOV1X>; Tue, 15 Jan 2002 16:27:23 -0500
Date: Tue, 15 Jan 2002 22:27:21 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: <arjanv@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
 the elegant solution)
In-Reply-To: <m16QaOc-000OVeC@amadeus.home.nl>
Message-ID: <Pine.LNX.4.33.0201152223480.11441-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002 arjanv@redhat.com wrote:

[...]
> > and no
> > way to actually use them to modify the kernel. I spent hours, putting
> > them in order, based upon the time/date stamp within the files, not
> > the file time which was something more or less random. I made a script
> > and tried, over a period of weeks, to patch the supplied kernel with
> > the supplied patches. Forget it. If anything in this universe is truly
> > impossible, then making a Red Hat distribution kernel from the provided
> > tools, patches, and sources is a definitive example.
> 
> Ok now you offend me. I spent quite a bit of time making the .spec file easy
> to read, AND we provide a convenient kernel-source rpm which installs
> /usr/src/linux (for RHL7.0) or /usr/src/linux-2.4 for 2.4 kernels (7.1/7.2) 
> which contains the full source AND all configs we used. AND if you type
> "make oldconfig" it picks the one you are currently running. Heck I even put
	 	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
that one I didn't know, I've always done a manual cp from configs/*.
Thanks for the hint. B-)  (And for the good job)

> Greetings,
>    Arjan van de Ven
>    Red Hat Linux kernel maintainer
>    

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

