Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUHIIhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUHIIhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUHIIhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:37:37 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:1723 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S266344AbUHIIhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:37:19 -0400
Subject: Re: [2.6.8-rc2-mm2] swsusp results on a hp compaq nx7000
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: crow@old-fsckful.ath.cx, mochel@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040808182440.GB620@elf.ucw.cz>
References: <20040804120303.GA1828@final-judgement.ath.cx>
	 <20040806201107.GD30518@elf.ucw.cz>
	 <20040808092853.GC26305@old-fsckful.ath.cx>
	 <20040808182440.GB620@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092039852.28673.5.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 09 Aug 2004 18:24:12 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-08-09 at 04:24, Pavel Machek wrote:
> Hi!
> 
> > > > * locking with regard to preemption seems so be broken
> 
> I see it here, too.
> 
> > > > * ohci1394 seems to generate sporadic OOPs on resume (could be
> > > >   preemption related)
> 
> I do not have firewire device to test with... There seem to be very
> little of those beasts around, so I propose to ignore firewire for
> now.

I have firewire hardware but no actual devices to plug in. Is that any
help at all when it comes to testing? (I'm not building any support in
or as modules at the moment).

Nigel

