Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUHHN3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUHHN3J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 09:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUHHN3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 09:29:09 -0400
Received: from mproxy.gmail.com ([216.239.56.247]:46103 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265314AbUHHN3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 09:29:06 -0400
Message-ID: <944a037704080806294224cab7@mail.gmail.com>
Date: Sun, 8 Aug 2004 09:29:02 -0400
From: Michael Guterl <mguterl@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: USB troubles in rc2
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       "Luis Miguel =?ISO-8859-1?Q?=20Garc=FD?= Mancebo" <ktech@wanadoo.es>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.44L0.0408080019320.13020-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.44L0.0408080019320.13020-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah I have to work today, Sunday!?!?  After I get off if I have time
I'll start messing with the bk-usb and bk-acpi patches.

On Sun, 8 Aug 2004 00:20:43 -0400 (EDT), Alan Stern
<stern@rowland.harvard.edu> wrote:
> On Sat, 7 Aug 2004, Michael Guterl wrote:
> 
> > What if Alan's assumptions that it is in ACPI and not USB are correct?
> >  Personally I don't know enough to handle really any of the tasks you
> > suggested.  I figured the fact that reverting bk-acpi.patch and
> > bk-usb.patch would throw up some kind of red flag, that something in
> > there was maybe messed up and merged in.
> 
> It was a guess, not an assumption!
> 
> You could test this guess by reverting bk-usb.patch while leaving
> bk-acpi.patch intact.
> 
> Alan Stern
> 
>
