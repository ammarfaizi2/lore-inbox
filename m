Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSGOM0F>; Mon, 15 Jul 2002 08:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSGOM0E>; Mon, 15 Jul 2002 08:26:04 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:12727 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317458AbSGOM0D>; Mon, 15 Jul 2002 08:26:03 -0400
Date: Mon, 15 Jul 2002 14:27:13 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207151227.g6FCRDlo020618@burner.fokus.gmd.de>
To: andre@linux-ide.org, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Andre Hedrick <andre@linux-ide.org>

>> >Now your silly PCATA stupid ass Tailgate Bridge that you are boasting
>> >about does some of the worst things anyone could ever imagine.
>> 
>> ???? Looks stupid (like dou did not get the message).

>I guess I need to break it down to simple terms, and hoped that your
>broadcast in expertise could cover your mouth.  This makes it harder for
>me because I do not communicate well over email.

>Firewire 1394, USB, Parallel Port, PCMCIA/CardBus are all effective
>tailgates via an alternate physical transport layer and protocol.
>Therefore it should be obvious many different versions of the hardware get
>it wrong.  Now in other operating system which are commerial based, there
>are device specific drivers to perform soft-protocol corrections to
>generate the appearance of a perfect product.  Much as in optics, here is
>another case where two wrongs make a right.  COSTAR for Hubble Space
>Telescope is real world example.

If _you_ had the experience you pretend, then why do you claim that the fact 
that I cannot use ide-scsi with a PCATA connection to my CD writer is caused
by bad hardware?

As the drive becomes usable with CDROM_SEND_PACKET and is completely unusable 
via ide-scsi it is obvious that the reason cannot be a hardware problem but must 
be a driver design bug.


>If you knew anything about the production industry, and maybe you do, it
>would be obvious that most of the Far East and Pacific Ring hardware
>people are still creating product based on SFF-8020 a retired document.

If this affects the drivers, then there need to be a workaround regardless of 
the driver layering model in use.

>> I am not whining, but you answer with  unrelated stuff. Why? Are you missing
>> experience and arguments?

>I just asked you for a formal preferred model coresponding to READ/WRITE
>10/16 fixed to the OS standard CDB as the base of a Packet Interface, yet
>you counter with a redirect. :-/

>Put up or shut up.

>Insert "Joerg Schilling" Perfect Packet Interface for review.

Why didn't you read my short abstract I send out yesterday?

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
