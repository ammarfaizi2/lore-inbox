Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbTEFIwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbTEFIwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:52:30 -0400
Received: from boden.synopsys.com ([204.176.20.19]:129 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP id S262459AbTEFIw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:52:29 -0400
Date: Tue, 6 May 2003 11:04:50 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Hans-Georg Thien <1682-600@onlinehome.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh a  PS/2 Trackpad
Message-ID: <20030506090450.GG890@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <3EB19625.6040904@onlinehome.de.suse.lists.linux.kernel> <3EB6EA2D.9050208@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB6EA2D.9050208@onlinehome.de>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Georg Thien, Tue, May 06, 2003 00:48:13 +0200:
> Hans-Georg Thien <1682-600@onlinehome.de> writes:
> 
> >The short story
> >---------------
> >Apple MacIntosh iBook Notebooks computers have a nice feature that
> >prevents unintended trackpad input while typing on the keyboard. There
> >are no mouse-moves or mouse-taps for a short period of time after each
> >keystroke. I wanted to have this feature on my i386 notebook ...
> 
> I have eliminated the use of a timer. The patch has been simple before, 
> and now it is even more simple :)
> 
> 
> diff -urN -X /tmp/dontdiff 
> /usr/src/linux-2.4.20/Documentation/Configure.help 
> /usr/src/linux/Documentation/Configure.help
> --- /usr/src/linux-2.4.20/Documentation/Configure.help	Fri Nov 29 
> 00:53:08 2002
> +++ /usr/src/linux/Documentation/Configure.help	Thu May  1 02:12:04 
> 2003

Very needed thing, thanks a lot.
But could you please be more careful with these line wraps?
One have to apply your patch per hand.

