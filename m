Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289512AbSBEN7i>; Tue, 5 Feb 2002 08:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289507AbSBEN71>; Tue, 5 Feb 2002 08:59:27 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:64260 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289511AbSBEN7J>; Tue, 5 Feb 2002 08:59:09 -0500
Message-Id: <200202051357.g15DvDt22229@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFC] List of maintainers
Date: Tue, 5 Feb 2002 15:57:14 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200202051015.g15AFDt19761@Port.imtp.ilyichevsk.odessa.ua> <20020205115713.D6672@suse.cz>
In-Reply-To: <20020205115713.D6672@suse.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 February 2002 08:57, you wrote:
> > This is first draft. I picked some names and addresses and made entried
> > for them.
> > If you want to be in this list, mail me your corrected entry. Please
> > indicate what kind of reports you wish to receive and what kind of
> > reports you DON'T want to see.
> >
> > If you don't want to be in this list, mail me too - I'll remove your
> > entry.
> >
> > This is the very first draft.
>
> Ok, here's my entry:
>
> Vojtech Pavlik <vojtech@ucw.cz> [5 feb 2002]
> 	Input device drivers (drivers/input/*, drivers/char/joystick/*).
> 	Some USB drivers (printer, acm, catc, hid*, usbmouse, usbkbd, wacom).
> 	VIA IDE support.

I want these entries to sound like "Hey, I am working on these parts of the 
kernel, if you have something, send it to me not to Linus". With precise 
indication of those parts and your level of involvement:

Vojtech Pavlik <vojtech@ucw.cz> [5 feb 2002]
	Feel free to send me bug reports and patches to input device drivers
	(drivers/input/*, drivers/char/joystick/*) and USB drivers
	(printer, acm, catc, hid*, usbmouse, usbkbd, wacom).
	Also CC me if you are posting VIA IDE driver related message
	(although I am not IDE subsystem maintainer).

Does this look right?
--
vda
