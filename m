Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132533AbRDHKxG>; Sun, 8 Apr 2001 06:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132534AbRDHKw5>; Sun, 8 Apr 2001 06:52:57 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:54546 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132533AbRDHKwl>; Sun, 8 Apr 2001 06:52:41 -0400
Date: 08 Apr 2001 12:25:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: twaugh@redhat.com
cc: jgarzik@mandrakesoft.com
cc: linux-kernel@vger.kernel.org
Message-ID: <7zSF$ISHw-B@khms.westfalen.de>
In-Reply-To: <20010407200856.E3280@redhat.com>
Subject: Re: Multi-function PCI devices
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20010407200856.E3280@redhat.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

twaugh@redhat.com (Tim Waugh)  wrote on 07.04.01 in <20010407200856.E3280@redhat.com>:

> On Sat, Apr 07, 2001 at 01:23:27PM -0400, Jeff Garzik wrote:
>
> > You asked in your last message to show you code, here is a short
> > example.  Note that I would love to rip out the SUPERIO code in parport
> > and make it a separate driver like this short, contrived example.  Much
> > more modular than the existing solution.
>
> (The superio code is on its way out anyway, for different reasons..)
>
> More modular?  Yes, it adds another module to support a card, so yes
> there are more modules.
>
> But with the multifunction_quirks approach, support is a question of
> adding two lines in a table.

So why not make Jeff's example use a multifunction board table to do it's  
job?

MfG Kai
