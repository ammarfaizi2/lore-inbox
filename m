Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274749AbRIURr7>; Fri, 21 Sep 2001 13:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274730AbRIURrt>; Fri, 21 Sep 2001 13:47:49 -0400
Received: from [209.202.108.240] ([209.202.108.240]:2567 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S274690AbRIURrm>; Fri, 21 Sep 2001 13:47:42 -0400
Date: Fri, 21 Sep 2001 13:47:42 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: David Hollister <david@digitalaudioresources.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dumb(?) question about .config file
In-Reply-To: <3BAB7C54.8000704@digitalaudioresources.org>
Message-ID: <Pine.LNX.4.33.0109211347010.2079-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, David Hollister wrote:

> I have what may be a dumb question, but I can't seem to find a suitable answer.
>
> Let's say you install RedHat out of the box.  When you do that, even if you
> install the kernel source, you don't get a .config file.  Is there some way to
> create a .config file based on the running kernel?
>
> I thought "make oldconfig" would do it, but from what I've read, it doesn't
> sound like that's necessarily true.

Install the kernel SRPM and look in the SOURCES directory. They're all there.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

