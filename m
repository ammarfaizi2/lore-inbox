Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTLOTyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 14:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264123AbTLOTyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 14:54:43 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:9372
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S263913AbTLOTyg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 14:54:36 -0500
Date: Mon, 15 Dec 2003 15:02:28 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031215150228.A10222@animx.eu.org>
References: <20031212131704.A26577@animx.eu.org> <20031212194439.GB11215@win.tue.nl> <20031212163545.A26866@animx.eu.org> <20031213132208.GA11523@win.tue.nl> <20031213171800.A28547@animx.eu.org> <20031214144046.GA11870@win.tue.nl> <20031214112728.A8201@animx.eu.org> <20031214202741.GA11909@win.tue.nl> <20031214162348.A8691@animx.eu.org> <20031214220346.GA11927@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20031214220346.GA11927@win.tue.nl>; from Andries Brouwer on Sun, Dec 14, 2003 at 11:03:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Yes, and that is what the kernel used to do.
> > > In general, however, the answer is unreliable. 
> > 
> > anyway to get this unreliable answer back?  =)
> 
> Easy enough, the code is still there, just the result is no longer used.
> 
> But unless you have good reason, you should not wish those old times
> back. This geometry stuff has caused such a large amount of pain.

Maybe atleast an option?  I personally have not had any pain with it.

> Set your geometry to the constant */255/63 - depending on precisely
> what you did, that may already have been what you got from 2.4 anyway.
> Complain if you have troubles - specify BIOS type, geometry, operating
> system that has problems booting.

The OS Is one of Windows 98, 2000, NT4, and in the future possibly XP.  BIOS
type varies.  Could be Dell's, the ones on hp compaq, award, phoenix, or
ami.

I use this so I don't ever have to boot dos to configure the drive
(partition) then boot back to linux to do what I need to do.

(OT: IT takes me 10 minutes or less to load the OS and everything with the
linux boot system I'm using.  I can't get the OS loaded from their CD that
quick!)

> I hope we'll find out that everything can be made to work without
> kernel support.

For me, this would be the easiest.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
