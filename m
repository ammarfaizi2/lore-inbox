Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUAETKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUAETKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:10:34 -0500
Received: from tag.witbe.net ([81.88.96.48]:8709 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265291AbUAETKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:10:19 -0500
Message-Id: <200401051910.i05JA6D28995@tag.witbe.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Davide Libenzi'" <davidel@xmailserver.org>,
       "'Vojtech Pavlik'" <vojtech@suse.cz>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Daniel Jacobowitz'" <dan@debian.org>, "'Rob Love'" <rml@ximian.com>,
       <rob@landley.net>, "'Pascal Schmidt'" <der.eremit@email.de>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Greg KH'" <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Date: Mon, 5 Jan 2004 20:10:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <Pine.LNX.4.44.0401050944420.17134-100000@bigblue.dev.mdolabs.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcPTtmiqWhhdHh9XQ/q4SWfFyIwdlwAByIlQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > Two dimensional discrete space (*) is enumerable. Just 
> start at [0,0]
> > and assign numbers going around the center in a growing spiral (**).
> > That way you assign a number to every point in that space. 
> This is very
> > similar to the trick used to demonstrate fractions are enumerable.
> 
> Vojtech, a spiral (in the math sense) won't work because whatever 
> continuos function you choose for the radius, you are going to skip 
> integers when the radius grows (and duplicate them when it's 
> small). Also, 
> IIRC, fractions are enumerable because they're a mapping from two 
> enumerable spaces (integers): F = F(I1, I2) = I1 / I2.
> 
No, I think Vojtech was meaning this kind of spiral and
enumeration :

  ...16 15 14 13
     5  4  3  12
     6  1  2  11
     7  8  9  10  

and so on... The spiral in not to be taken in the math sense...

Regards,
Paul

