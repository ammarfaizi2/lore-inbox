Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278537AbRJXO4Y>; Wed, 24 Oct 2001 10:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278543AbRJXO4D>; Wed, 24 Oct 2001 10:56:03 -0400
Received: from mail026.mail.bellsouth.net ([205.152.58.66]:34475 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278541AbRJXOz5>; Wed, 24 Oct 2001 10:55:57 -0400
Message-ID: <3BD6D6AC.B9CF58EB@mandrakesoft.com>
Date: Wed, 24 Oct 2001 10:56:44 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, jes@trained-monkey.org
Subject: Re: acenic breakage in 2.4.13-pre
In-Reply-To: <20011024164533.C15474@sith.mimuw.edu.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Rekorajski wrote:
> 
> On Tue, 23 Oct 2001, Jeff Garzik wrote:
> 
> > If there are no complaints nor better suggestions, I would prefer to use
> > the code in acenic.c / 8139cp.c as a base, since that code has been
> > stable for a little while.
> 
> Speaking of acenic - it's broken in 2.4.13-pre. I have 3c985 and all I
> get with 2.4.13-pre is "Firmware NOT running!". After I backed the
> changes from -pre patch it started and works fine. Maybe the problem is
> I have it in 32bit PCI slot?

Several people have reported this bug.

Alexey, are the 2.4.13 acenic changes yours?  You had mentioned hacking
on it...  Jes, the maintainer, is CC'd too.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

