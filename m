Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262927AbTDAXLZ>; Tue, 1 Apr 2003 18:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262930AbTDAXLZ>; Tue, 1 Apr 2003 18:11:25 -0500
Received: from smtp-out.comcast.net ([24.153.64.109]:53654 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S262927AbTDAXLX>;
	Tue, 1 Apr 2003 18:11:23 -0500
Date: Tue, 01 Apr 2003 18:20:43 -0500
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: [Bug 529] New: ACPI under 2.5.50+ (approx) locks system hard
	during bootup
In-reply-to: <200304020107.58676.josh@stack.nl>
To: Jos Hulzink <josh@stack.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1049671247.27e955@bittwiddlers.com>
Message-id: <20030401232043.GA10066@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Delivery-Agent: TMDA/0.68 (Shut Out)
X-Primary-Address: mharrell@bittwiddlers.com
References: <130680000.1049224849@flay>
 <20030401114749.A7647@figure1.int.wirex.com>
 <20030401195514.GA29214@bittwiddlers.com> <200304020107.58676.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I sympathize since I've been feeling the same way.  When I mentioned it to
Andrew in response to another ACPI problem I saw posted he recommended I
send it via bugzilla to see if more people will pay attention then.

But, in the ACPI team's defense, I also have about three other computers with
ACPI that do work fine and I've seen a number of other people on the ACPI list
without problems.  In my case it's annoying since it's my laptop which has
the problem and that's the only one that I really care about when it comes to
ACPI.

I suggest you read through my initial email and see if you find anything
unusually different in your setup.  I'm not positive since I'm new to bugzilla
but if you do have anything different that you notice then go to 
bugzilla.kernel.org under bug 529 and add on to the bug report.  Sounds like
the more info the better for this bug



: The only way I can boot recent 2.5 kernels is to make sure my BIOS does 
: nothing that even smells like ACPI. The only response I got so far on the 
: lkml is "disable acpi support" and "disable apic support". The only 
: conclusion I can make is that the ACPI support in 2.5 is buggy enough to 
: prevent 2.5 to emerge into 2.6 for a long time from now, and unfortunately 
: nobody seems to care. I detected big IRQ / ACPI / APIC trouble since about  
: 2.5.44 - 2.5.53, and nothing has changed since. 
: 
: NFI, I just don't understand that a core problem that prevents me from booting 
: 2.5 kernels, is noticed by so few others that it is able to remain unfixed 
: for so long.

-- 
  Matthew Harrell                          The perversity of the universe 
  Bit Twiddlers, Inc.                       tends to a maximum.
  mharrell@bittwiddlers.com     
