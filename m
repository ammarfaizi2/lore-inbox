Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUHHEUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUHHEUs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 00:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUHHEUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 00:20:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54541 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S265074AbUHHEUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 00:20:46 -0400
Date: Sun, 8 Aug 2004 00:20:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Michael Guterl <mguterl@gmail.com>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>,
       =?ISO-8859-1?Q?Luis_Miguel_Garc=FD_Mancebo?= <ktech@wanadoo.es>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
Subject: Re: [linux-usb-devel] Re: USB troubles in rc2
In-Reply-To: <944a03770408072019362f4a33@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0408080019320.13020-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2004, Michael Guterl wrote:

> What if Alan's assumptions that it is in ACPI and not USB are correct?
>  Personally I don't know enough to handle really any of the tasks you
> suggested.  I figured the fact that reverting bk-acpi.patch and
> bk-usb.patch would throw up some kind of red flag, that something in
> there was maybe messed up and merged in.

It was a guess, not an assumption!

You could test this guess by reverting bk-usb.patch while leaving 
bk-acpi.patch intact.

Alan Stern

