Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbSL2Qg6>; Sun, 29 Dec 2002 11:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbSL2Qg6>; Sun, 29 Dec 2002 11:36:58 -0500
Received: from [81.2.122.30] ([81.2.122.30]:35845 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265081AbSL2Qg5>;
	Sun, 29 Dec 2002 11:36:57 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212291644.gBTGi79G001294@darkstar.example.net>
Subject: Re: holy grail
To: anomalous_force@yahoo.com (Anomalous Force)
Date: Sun, 29 Dec 2002 16:44:07 +0000 (GMT)
Cc: riel@conectiva.com.br, wa@almesberger.net, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021229155600.95805.qmail@web13204.mail.yahoo.com> from "Anomalous Force" at Dec 29, 2002 07:56:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This has been said before, but "for some reason" everybody
> > who said it went quiet the moment they started working on
> > a patch and have never been heard from again.
> > 
> > Either they're still working on the problem (after a four
> > years) or they've moved on to an easier/realistic project.
> 
> i have stated this would be extremely difficult. no single person
> could attempt this without the support of the other developers as
> the effort must include all aspects of the kernel to some extent.
> the original discussion for this was to show that kexec() _could_
> become something that is a holy grail amoung kernel developers:
> hot-swap.

Why take the easy road, ( :-) ),  and merely make the kernel
hot-swappable?  You could use the code from the User Mode Linux
project as a starting point for creating a Meta Kernel Mode linux
project, and run several more kernel images concurrently as user mode
processes of the top-level kernel, and then add necessary to connect
any particular physical hardware to the MKML virtual machines.

Then, you could migrate your applications from kernel to kernel
without ever having to re-boot.

Mainframe power on the desktop :-)

John.
