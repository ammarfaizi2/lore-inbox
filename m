Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289711AbSBESDh>; Tue, 5 Feb 2002 13:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289726AbSBESDR>; Tue, 5 Feb 2002 13:03:17 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:49157 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289711AbSBESDC>;
	Tue, 5 Feb 2002 13:03:02 -0500
Date: Tue, 5 Feb 2002 10:00:37 -0800
From: Greg KH <greg@kroah.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] List of maintainers
Message-ID: <20020205180037.GC1052@kroah.com>
In-Reply-To: <200202051015.g15AFDt19761@Port.imtp.ilyichevsk.odessa.ua> <20020205115713.D6672@suse.cz> <200202051357.g15DvDt22229@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202051357.g15DvDt22229@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 08 Jan 2002 15:30:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 03:57:14PM -0200, Denis Vlasenko wrote:
> On 5 February 2002 08:57, you wrote:
> > > This is first draft. I picked some names and addresses and made entried
> > > for them.
> > > If you want to be in this list, mail me your corrected entry. Please
> > > indicate what kind of reports you wish to receive and what kind of
> > > reports you DON'T want to see.
> > >
> > > If you don't want to be in this list, mail me too - I'll remove your
> > > entry.
> > >
> > > This is the very first draft.
> >
> > Ok, here's my entry:
> >
> > Vojtech Pavlik <vojtech@ucw.cz> [5 feb 2002]
> > 	Input device drivers (drivers/input/*, drivers/char/joystick/*).
> > 	Some USB drivers (printer, acm, catc, hid*, usbmouse, usbkbd, wacom).
> > 	VIA IDE support.
> 
> I want these entries to sound like "Hey, I am working on these parts of the 
> kernel, if you have something, send it to me not to Linus". With precise 
> indication of those parts and your level of involvement:

Um, isn't that what Vojtech said?  You just converted his response into
full sentances.

But I'm curious why you want to sort the list of maintainers by the
maintainer name.  Isn't the format of the current MAINTAINERS file much
nicer in that it's sorted by subsystem and driver type?  For if you want
to know who to send your USB Printer driver changes to, you just look
that up, instead of having to search through your file, which is ordered
in the other way.

So in short, why are you trying to do this?

thanks,

greg k-h
