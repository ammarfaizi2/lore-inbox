Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWIYLHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWIYLHJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWIYLHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:07:09 -0400
Received: from animx.eu.org ([216.98.75.249]:9613 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1751132AbWIYLHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:07:07 -0400
Date: Mon, 25 Sep 2006 06:59:08 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Roman Glebov <sleon@sleon.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: megaraid question
Message-ID: <20060925105908.GA9897@animx.eu.org>
Mail-Followup-To: Roman Glebov <sleon@sleon.dyndns.org>,
	linux-kernel@vger.kernel.org
References: <20060925012909.A56E52963F@sleon.dyndns.org> <20060925015126.GA8764@animx.eu.org> <200609250417.41995.sleon@sleon.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609250417.41995.sleon@sleon.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Glebov wrote:
> Am Montag, 25. September 2006 03:51 schrieb Wakko Warner:
> > Keep me in CC.
    ^^^^^^^^^^^^^^

> > sleon@sleon.dyndns.org wrote:
> > > i am using opensource megaraid driver (2.6.17) . Do you know any
> > > opensource monitoring tool for the opensource megaraid drivers Or is
> > > there a way to check the state of harddrives connected to the megaraid
> > > controller?
> >
> > I'd like to add a "ME TOO" here.  as well as one for the adaptec raid
> > cards.
> >
> > Last time I looked, the only software I could find for megaraid was a
> > program from Dell (binary only unfortunately)
> Hi, thanks for answering me!
> 
> If i find something out i will let you know.

That'd be great.

> THe last info i got is that it is somehow possible with smartmon tools.
> (a la smartctl -d megaraid,0 /dev/sda)

I have never tried this.

> I am asking smartmontools developers right now, because there is no out of the 
> box support for megaraid.
> 
> Also i was told that there is a binary monitoring tool from lsi-logic page.
> 
> But will it work with open source driver?

I'm not sure about the program from LSI, but the one from Dell seems to work
with any megaraid controller (the one I do have happens to be a dell
megaraid card).  The program I used from that package looks very similar to
the bios configuration tool and you can change disk layouts from within the
program while still in linux.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
