Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbSLESzv>; Thu, 5 Dec 2002 13:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbSLESzv>; Thu, 5 Dec 2002 13:55:51 -0500
Received: from ahriman.bucharest.roedu.net ([141.85.128.71]:21411 "HELO
	ahriman.bucharest.roedu.net") by vger.kernel.org with SMTP
	id <S267365AbSLESzu>; Thu, 5 Dec 2002 13:55:50 -0500
Date: Thu, 5 Dec 2002 21:21:11 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: <dizzy@ahriman.bucharest.roedu.net>
To: Dave Olien <dmo@osdl.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Monitor utility (was Re: DAC960 at 2.5.50)
In-Reply-To: <20021205094500.A6769@acpi.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0212052105300.22842-100000@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2002, Dave Olien wrote:

....
> I've heard of something Mylex provides called
> "global array manager" that runs on Linux.  But, I
> think it requires a graphical front end on a windows
> box.  I don't think it's open source either.
> I'll look it over as a second priority after
> this one.
>
> Dave
>

Hi Dave

Yes, their software its pretty cool and its the only choice for using some
of the features of the DAC960 (ex. MORE, setting queue tag len for single
hdd, write-back cache for logical and physical drives, very nice event
viewer, full SNMP variables exporting). They provide native linux
drivers/server and win32 client (inside a rpm and using wine to start
itself). Except for some minor visual problems the GAM client works pretty
well with wine.

I sugest you to try it out.

----------------------------
Mihai RUSU

Disclaimer: Any views or opinions presented within this e-mail are solely
those of the author and do not necessarily represent those of any company,
unless otherwise specifically stated.

