Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316384AbSETVQm>; Mon, 20 May 2002 17:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316385AbSETVQl>; Mon, 20 May 2002 17:16:41 -0400
Received: from ktk.bidmc.harvard.edu ([134.174.237.112]:14340 "EHLO
	ktk.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S316384AbSETVQk>; Mon, 20 May 2002 17:16:40 -0400
Message-ID: <3CE967B3.1F6DE1E2@bigfoot.com>
Date: Mon, 20 May 2002 17:16:35 -0400
From: "Kristofer T. Karas" <ktk@bigfoot.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en-GB, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Will Newton <will@misconception.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.18 and VIA USB
In-Reply-To: <E179T0J-0002gQ-00.2002-05-19-16-53-53@mail6.svr.pol.co.uk> <20020520175353.GB24443@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Sun, May 19, 2002 at 04:56:19PM +0100, Will Newton wrote:
> > hub.c: Cannot enable port 2 of hub 1, disabling port.
> > hub.c: Maybe the USB cable is bad?
>
> Which USB host controller driver are you using?
> And are you sure your cable isn't bad?  :)

Just a long shot, but ....

I get this message when I plug my Microsoft Internet keyboard (which has both PS/2
and USB interfaces) into my VIA-based MB, with both cables connected; if the
legacy PS/2 cable is in use, it causes the USB interface internal to the keyboard
to claim itself dead.  A feature, not a bug.

Kris

