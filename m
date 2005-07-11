Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVGKUGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVGKUGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVGKUEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:04:07 -0400
Received: from totor.bouissou.net ([82.67.27.165]:39101 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S262508AbVGKUC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:02:26 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Mon, 11 Jul 2005 22:02:16 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507111539280.6399-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507111539280.6399-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507112202.16876@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 11 Juillet 2005 21:43, Alan Stern a écrit :
> >
> > Enable USB mouse support: YES	(Well, I have one ;-)
>
> That's what I was talking about.  BIOS support for keyboard and mouse is
> called "Legacy" support, because it emulates plain old non-USB AT-type
> devices.  I bet if you turned off the "Enable USB mouse support" option
> then everything would work.

Aha. And what would be your advice ? Rather leave the BIOS mouse option ON and 
use "usb-handoff", or remove both ?

I'll check without both tomorrow anyway, it's a bit late tonight for keeping 
on breaking the machine ;-)

> > A thousand thanks for your suggestion Alan !
>
> You're welcome.

Well, you really deserve my thanks :-)

> A lot has changed since 2.4... not always for the better!

Hmmm... I've seen... 2.6.12 is the first release that seems to be willing to 
work on my system -- with some tweaking, coffee and aspirin. Previous 2.6.x 
releases I had tried (2.6.3, 2.6.6) were horribly broken on my poor VIA 
hardware ;-)

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
