Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319515AbSIGU3g>; Sat, 7 Sep 2002 16:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319517AbSIGU3g>; Sat, 7 Sep 2002 16:29:36 -0400
Received: from 62-190-217-141.pdu.pipex.net ([62.190.217.141]:55817 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S319515AbSIGU3f>; Sat, 7 Sep 2002 16:29:35 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209072041.g87KfJEk002074@darkstar.example.net>
Subject: Re: ide drive dying?
To: degger@fhm.edu (Daniel Egger)
Date: Sat, 7 Sep 2002 21:41:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1031429984.2723.29.camel@sonja.de.interearth.com> from "Daniel Egger" at Sep 07, 2002 10:19:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This discussion is becoming stupid, but here we go:

> > No, but you've upgraded the firmware, right?
> 
> Not exactly.

???  Either you did or didn't.

> According to IBM technical support there is no such thing
> as a new firmware. The drives are alright, the OS is broken.

Right, so you're calling Alan Cox a liar, then?  I know who I believe.

> > If that has fixed the problem, then it is not a faulty drive.
> Right, and how would you notice without sacrifying more data?

smartctl -X /dev/hda?

'Execute Extended Self Test' might be a good start

or you could just copy data to/from it, generally hammer it and spin it up, down, and sideways, generally try to make it go wrong, and if your data is intact, then I would trust it more than a disk that arrived in a jiffy bag, with an assurance that 'this one works'.

> > So, you'll just plug in your 'new' disk, and in a few months,
> > bad sectors will start appearing.
> 
> Not if you sold it at Ebay,

The bad sectors are just as likely to appear, but somebody else's data will be lost.  Very nice gesture, not to mention that you probably violate the Ebay T&C by selling a product that you suspect is faulty.

> which is what I did with all *new* drives I received from IBM.

Well, I won't buy a second hand drive from you then :-).

> I just kept the "serviceable used part" one in case I need to install
> Windows to upgrade the firmware of some drive or anything else in range.

Fine, if that's what floats your boat.

Infact, I was completely wrong, OK?  You were right all along, so there is no need to continue this pointless thread.

John.
