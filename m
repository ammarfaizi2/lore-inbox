Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319152AbSIDMZ2>; Wed, 4 Sep 2002 08:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319153AbSIDMZ1>; Wed, 4 Sep 2002 08:25:27 -0400
Received: from employees.nextframe.net ([212.169.100.200]:61423 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S319152AbSIDMZ1>; Wed, 4 Sep 2002 08:25:27 -0400
Date: Wed, 4 Sep 2002 14:31:15 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re:  writing OOPS/panic info to nvram?
Message-ID: <20020904143115.A117@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <200209041350.21358.roy@karlsbakk.net> <1031142093.2796.116.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031142093.2796.116.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 01:21:33PM +0100, Alan Cox wrote:
> On Wed, 2002-09-04 at 12:50, Roy Sigurd Karlsbakk wrote:
> > hi
> > 
> > I just read in the OS X.2 technote 
> > (http://developer.apple.com/technotes/tn2002/tn2053.html#TN001016) that 
> > they're writing the panic dump to nvram.
> > 
> > Is it hard to implement this on Linux?
> 
> Its been done years ago. However on a PC you basically have no free
> nvram so its not terribly useful there.

True - the 'normal' size on a PC is apparently something like 114 bytes ... 
I  guess we could use it for something useful ... but maybe not for
OOPSen/panics. 

I didn`t realize we only had 114 bytes to work with.

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
