Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTDXIoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTDXIoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:44:09 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13696 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261884AbTDXIoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:44:08 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304240859.h3O8x0bF000480@81-2-122-30.bradfords.org.uk>
Subject: Re: Flame Linus to a crisp!
To: jamie@shareable.org (Jamie Lokier)
Date: Thu, 24 Apr 2003 09:59:00 +0100 (BST)
Cc: john@grabjohn.com (John Bradford),
       wli@holomorphy.com (William Lee Irwin III),
       torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20030424083137.GF28253@mail.jlokier.co.uk> from "Jamie Lokier" at Apr 24, 2003 09:31:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > With open hardware designs, there would be no problem with
> > documentation not being available to write drivers.
> 
> See below...
> 
> > Incidently, using the Transmeta CPUs, is it not possible for the user
> > to replace the controlling software with their own code?  I.E. not
> > bother with X86 compatibility at all, but effectively design your own
> > CPU?  Couldn't we make the first Lin-PU this way?
> 
> In theory; in practice we have no access to documentation.  See above...

I'm now stuck in a mail reading loop, with the see above and see
belows :-)

> That makes Transmeta part of the _old_ industry :)
> 
> I believe present Transmeta CPUs are quite specialised for x86
> behaviour (memory model etc.) anyway.  When you're running on a CPU
> like that, there's probably little to be gained from changing to a
> different front-end instruction set.
> 
> Special tricks like non-cache-ping-ponging locks and faster interrupt
> handling might improve performance, but probably require a change of
> the hardware to implement.

Shame.  I guess it wouldn't really have got us any closer to an open
hardware design anyway, it just seemed like a nice hack :-).

John.
