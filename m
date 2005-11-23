Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVKWQWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVKWQWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVKWQWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:22:45 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:18079 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751046AbVKWQWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:22:44 -0500
Date: Wed, 23 Nov 2005 17:23:01 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Marc Koschewski <marc@osknowledge.org>, Jon Smirl <jonsmirl@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123162259.GD6970@stiffy.osknowledge.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <9e4733910511230719h67fa96bdxdeb654aa12f18e67@mail.gmail.com> <20051123160231.GC6970@stiffy.osknowledge.org> <20051123161637.GI15449@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123161637.GI15449@flint.arm.linux.org.uk>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King <rmk+lkml@arm.linux.org.uk> [2005-11-23 16:16:37 +0000]:

> Maybe that indicates your ACPI is buggy.  I don't know.  I know nothing
> about ACPI.

Dude ... this is a DELL mobile! ;) Worse.

> 
> > * What does these 'too much work' messages mean? Must have been come
> >   in lately...
> 
> It means that we spun in the serial interrupt for more than 256 times
> and reached the limit on the amount of work we were prepared to do.
> Any idea what you were doing when these happened?

Sure, I know: I booted with a 3com Bluetooth Card in one of the two PCMCIA
slots I have.

Shouldn't PCMCIA slot 1 be ttyS0, PCMCIA slot 2 be ttyS1 and any of the
other serial ports ie ttyS2 and so forth? I have infrared as well (which
is setup in BIOS as well as RS232 on the back.l Where are these? Not
that I would need it... ;)

Regards,
	Marc
