Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUBXL0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 06:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUBXL0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 06:26:05 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:29827 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262224AbUBXL0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 06:26:02 -0500
Date: Tue, 24 Feb 2004 12:26:00 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Helmut Auer <vdr@helmutauer.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: HELP Re: Keyboard not working under 2.6.2
Message-ID: <20040224112600.GB19216@MAIL.13thfloor.at>
Mail-Followup-To: Helmut Auer <vdr@helmutauer.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <403911AD.1030005@helmutauer.de> <403B101D.3070601@helmutauer.de> <20040224101154.GD993@cse.unsw.EDU.AU> <403B2C18.3070906@helmutauer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403B2C18.3070906@helmutauer.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 11:48:56AM +0100, Helmut Auer wrote:
> Hi Darren,
> 
> >What is the actual keyboard, I am using a logitech cordless USB connected
> >via a PS2 adapter that works OK.
> >
> Now I can work with an USB keyboard connected to USB or with an "normal" 
> PS/2 keyboard connected to the PS/2 pins via a standard PS/2 Slotblech 
> Adapter.
> 
> >Is the power supply in the keyboard OK
> Yes - as I said it works without problems, when I boot the 2.4.18 kernel
> 
> >Is there power at the IR receiver
> Yes
> 
> >Is the receiver connected to the PS2 ports.
> Yes - The receiver is only connecet to the keyboard dataa and keyboard 
> clock pins of the PS/2 connector., but that should be enough :-)

try with 2.6.3 or one of the bk snapshots, maybe 
this issue has already been fixed somehow ...

HTH,
Herbert

> Bye
> Helmut
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
