Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271863AbTGRQAO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271866AbTGRQAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:00:12 -0400
Received: from [64.65.189.210] ([64.65.189.210]:9450 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S271863AbTGRP7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:59:46 -0400
Subject: Re: Error compiling, scsi 2.6.0-test1
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: backblue <backblue@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030717195952.130827f5.backblue@netcabo.pt>
References: <Sea2-F42G9i3HGRgKuw00017dcf@hotmail.com>
	 <ODEIIOAOPGGCDIKEOPILAEBDCNAA.alan@storlinksemi.com>
	 <20030716232827.2272eccb.backblue@netcabo.pt>
	 <1058442701.8621.26.camel@dhcp22.swansea.linux.org.uk>
	 <20030717195952.130827f5.backblue@netcabo.pt>
Content-Type: text/plain
Message-Id: <1058544877.3699.4.camel@bubbles.imr-net.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 18 Jul 2003 09:14:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not to seem heartless, but it does work from 2.4, you may have to stick
with that till someone ports the driver forward.  Linux remains a
volunteer effort.  The kernel maintainers do not have a card to develop
against, and they don't need the hardware.  If no one else does either,
then the card becomes un-updated.   I would recommend finding people who
use the card, and trying to get some support for updating it.

have a nice day,


joshua

On Thu, 2003-07-17 at 11:59, backblue wrote:
> hello Alan,
> 
> I need this driver, but i dont know anouth of C, to code a new one, that old's on 2.6.0 :(, where to start? i really need it, i have everything scsi on my computer, with this controler, and i dont like the idea, of dont have suport to it!!
> On 17 Jul 2003 12:51:42 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > On Mer, 2003-07-16 at 23:28, backblue wrote:
> > > I have gcc 3.3, on x86 machine, i have this error, compiling the suport for my scsi card, someone know the problem?
> > 
> > Nobody has coverted this driver to 2.6 yet. If someone does then it will
> > get merged in, if not the initio support will get deleted in time.
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

