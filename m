Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293539AbSCGH0q>; Thu, 7 Mar 2002 02:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293538AbSCGH0h>; Thu, 7 Mar 2002 02:26:37 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:4843 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293539AbSCGH0Y>; Thu, 7 Mar 2002 02:26:24 -0500
Date: Thu, 7 Mar 2002 09:11:44 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Beef Arrowny <tanfhltu@yahoo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: Kernel Oops in 2.4.18 (ide.c)
In-Reply-To: <20020306230616.45503.qmail@web9904.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0203070909590.19993-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Beef Arrowny wrote:

> I think I've got all the right info, but here goes:
> 
> I'm trying to get my RICOH MP6200A CD-RW to work on
> this new machine I just built.  I've gotten it to work
> in the past, but it's always been blind luck.  This is
> the first time I've gotten an oops however.

I sent a patch to fix the oops, but not the underlying problem a while 
back, so thats probably why it hasn't made it into mainline. Jens might 
know wether the drive is a problematic one.

Regards,
	Zwane

