Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319158AbSIDMtA>; Wed, 4 Sep 2002 08:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319159AbSIDMs7>; Wed, 4 Sep 2002 08:48:59 -0400
Received: from employees.nextframe.net ([212.169.100.200]:42737 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S319158AbSIDMs7>; Wed, 4 Sep 2002 08:48:59 -0400
Date: Wed, 4 Sep 2002 14:54:46 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re:   writing OOPS/panic info to nvram?
Message-ID: <20020904145446.B117@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <200209041350.21358.roy@karlsbakk.net> <1031142093.2796.116.camel@irongate.swansea.linux.org.uk> <20020904143115.A117@sexything> <1031143752.2788.118.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031143752.2788.118.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 01:49:12PM +0100, Alan Cox wrote:
> On Wed, 2002-09-04 at 13:31, Morten Helgesen wrote:
> > True - the 'normal' size on a PC is apparently something like 114 bytes ... 
> > I  guess we could use it for something useful ... but maybe not for
> > OOPSen/panics. 
> > 
> > I didn`t realize we only had 114 bytes to work with.
> 
> We don't. They are all used by the BIOS

That makes it even less useful. Oh well.

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
