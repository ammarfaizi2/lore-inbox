Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290573AbSBOSWS>; Fri, 15 Feb 2002 13:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290565AbSBOSWI>; Fri, 15 Feb 2002 13:22:08 -0500
Received: from air-2.osdl.org ([65.201.151.6]:60547 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S290574AbSBOSV4>;
	Fri, 15 Feb 2002 13:21:56 -0500
Date: Fri, 15 Feb 2002 10:22:05 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
        <linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.5.5-pre1 rmmod usb-uhci hangs
In-Reply-To: <Pine.LNX.4.33.0202150956400.829-100000@segfault.osdlab.org>
Message-ID: <Pine.LNX.4.33.0202151019590.829-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Feb 2002, Patrick Mochel wrote:

> 
> > no, it doesn't solve the problem. i would like to test it whith 
> > preemtible kernel not set but it doesn't boot.
> 
> While Greg's patch did fix part of the problem, the rest of it was on my 
> end. Could you try this patch, and see if helps?

Actually, the patch that I sent is against my current tree, which includes 
some changes that I've already pushed to Linus. If you're using BK, you 
should be able to pull his current tree (if you're into that kinda thing). 
Or, wait until -pre2. Sorry about that.

	-pat

