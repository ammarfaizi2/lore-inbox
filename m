Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUACL6D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 06:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUACL6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 06:58:02 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:38060 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261659AbUACL6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 06:58:00 -0500
Date: Sat, 3 Jan 2004 19:57:57 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: udev and devfs - The final word 
In-Reply-To: <200401030651.i036p8mb009710@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0401031956090.4407-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jan 2004 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 02 Jan 2004 22:07:48 PST, Greg KH <greg@kroah.com>  said:
> 
> > What is "efficiently"?  No one really cares about milliseconds here,
> > seconds are even tollerable at least for small seconds :)
> 
> Anybody who's had to sit and watch a Sun E10K enumerate 400+ disks
> will disagree with that, unless "small seconds" are tiny fractions thereof. :)
> 
> 
> 

Even an old E3500 with only 70 or so disks and the evil RDAC is enough.

Ian


