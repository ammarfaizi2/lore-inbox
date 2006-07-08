Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWGHRWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWGHRWx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWGHRWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:22:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30668 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964911AbWGHRWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:22:52 -0400
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olivier Galibert <galibert@pobox.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Bojan Smojver <bojan@rexursive.com>, Jan Rychter <jan@rychter.com>,
       Pavel Machek <pavel@ucw.cz>, Avuton Olrich <avuton@gmail.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
In-Reply-To: <20060708164312.GA36499@dspnet.fr.eu.org>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <20060707215656.GA30353@dspnet.fr.eu.org>
	 <20060707232523.GC1746@elf.ucw.cz>
	 <200607080933.12372.ncunningham@linuxmail.org>
	 <20060708002826.GD1700@elf.ucw.cz> <m2d5cg1mwy.fsf@tnuctip.rychter.com>
	 <1152353698.2555.11.camel@coyote.rexursive.com>
	 <1152355318.3120.26.camel@laptopd505.fenrus.org>
	 <20060708164312.GA36499@dspnet.fr.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 08 Jul 2006 18:39:23 +0100
Message-Id: <1152380363.27368.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-07-08 am 18:43 +0200, ysgrifennodd Olivier Galibert:
> On Sat, Jul 08, 2006 at 12:41:58PM +0200, Arjan van de Ven wrote:
> > Very often, choice is good. but for something this fundamental, it is
> > not. We also don't have 2 scsi layers for example.
> 
> We have 2 ide layers, 2 usb-storage drivers, 2 sound systems and we

(We've had effectively two SCSI layers before now btw when we've done
transitions from old_eh to new_eh)

> have had 2 pcmcia subsystems and 2 usb subsystems.  At one point, it's
> the only way to find out what will work out.  Suspend2 and uswsusp
> have very different fundamental designs, and it's quite unclear at
> that point which one is the right one.

I'd like to see this cleared up at OLS/Kernel summit. 

Alan

