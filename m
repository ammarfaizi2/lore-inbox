Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285927AbRLYVyH>; Tue, 25 Dec 2001 16:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285944AbRLYVxx>; Tue, 25 Dec 2001 16:53:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3848 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285937AbRLYVxn>; Tue, 25 Dec 2001 16:53:43 -0500
Subject: Re: 
To: garzik@havoc.gtf.org (Legacy Fishtank)
Date: Tue, 25 Dec 2001 22:03:59 +0000 (GMT)
Cc: manfred@colorfullife.com (Manfred Spraul), klink@clouddancer.com (Colonel),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011225141441.A14941@havoc.gtf.org> from "Legacy Fishtank" at Dec 25, 2001 02:14:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Izg0-0008Bm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's required by newer RedHat and MDK initscripts, perhaps others.
> ip, iproute and similar utilities use it, and so since it's commonly

Basically because Dave refused to recognize lots of embedded setups don't
need the netlink crap and couldn't just accept defaulting it to Y we all
get lumbered with it

> required DaveM made it unconditional...  I think the checkin comment was
> something along the lines of "make it unconditional unless Alan
> complains about kernel bloat" :)

And I did complain. "Red Hat needs XYZ so we make it mandatory" is not an
appropriate approach to a problem.

Alan
