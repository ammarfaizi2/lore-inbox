Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270212AbTGMKqA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 06:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270214AbTGMKqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 06:46:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64262 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270212AbTGMKp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 06:45:59 -0400
Date: Sun, 13 Jul 2003 12:00:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jaakko Niemi <liiwi@lonesom.pp.fi>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Wiktor Wodecki <wodecki@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hang with pcmcia wlan card
Message-ID: <20030713120040.C2621@flint.arm.linux.org.uk>
Mail-Followup-To: Jaakko Niemi <liiwi@lonesom.pp.fi>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wiktor Wodecki <wodecki@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <87fzldxcf5.fsf@jumper.lonesom.pp.fi> <873chbyasi.fsf@jumper.lonesom.pp.fi> <20030712173039.A17432@flint.arm.linux.org.uk> <20030712164855.GB2133@gmx.de> <1058086011.31919.39.camel@dhcp22.swansea.linux.org.uk> <87wuemg3h2.fsf@jumper.lonesom.pp.fi> <20030713110016.A2621@flint.arm.linux.org.uk> <87he5qg0sp.fsf@jumper.lonesom.pp.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87he5qg0sp.fsf@jumper.lonesom.pp.fi>; from liiwi@lonesom.pp.fi on Sun, Jul 13, 2003 at 01:48:22PM +0300
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 01:48:22PM +0300, Jaakko Niemi wrote:
> Russell King <rmk@arm.linux.org.uk> writes:
> > I won't even bother putting this into my bk tree and asking Linus to
> > pull; I'm sure someone else will integrate this into the kernel tree
> > for me.  (as happened previously, and as a result I need to sort out
> > my bk tree.)
> 
>  I guess testing with a bit of different hardware would be good.

Oddly, that's what the rest of the community is for.  Developers don't
have access to all possible combinations of hardware.

However, the patch to ti113x.h came from 2.4-ac, and afaik there haven't
been any reports of failure there.  Also note that I was just the middle
man in getting the original patch applied.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

