Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbUBXKML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 05:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbUBXKML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 05:12:11 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:62857 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262174AbUBXKMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 05:12:00 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Helmut Auer <vdr@helmutauer.de>
Date: Tue, 24 Feb 2004 21:11:54 +1100
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: HELP Re: Keyboard not working under 2.6.2
Message-ID: <20040224101154.GD993@cse.unsw.EDU.AU>
References: <403911AD.1030005@helmutauer.de> <403B101D.3070601@helmutauer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403B101D.3070601@helmutauer.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helmut

What is the actual keyboard, I am using a logitech cordless USB connected
via a PS2 adapter that works OK.

Is the power supply in the keyboard OK
Is there power at the IR receiver
Is the receiver connected to the PS2 ports.

Darren


On Tue, 24 Feb 2004, Helmut Auer wrote:

> 
> >Hello,
> >
> >I am using an Intel810 MoBo with an infrared module/keyboard connected to
> >an onboard PS/2 connector.
> >With a 2.4.x kernel I get the message:
> >No AT keyboard found
> >but the keyboard works fine.
> >With a 2.6.2 kernel, I don't get this message, but the keyboard does not
> >work !!!
> >Any hints what I can try ? If I connect an USB keyboard, this will 
> >work, and also if I connect a "normal" PS/2 keyboard to that PS/2 pins.
> 
> 
> Sorry for being impatient, but isn't here anyone who can give me a hint, 
> or is this the wrong place for this problem ?
> 
> -- 
> Helmut Auer, helmut@helmutauer.de
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
