Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266099AbRF2OgM>; Fri, 29 Jun 2001 10:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266098AbRF2OgC>; Fri, 29 Jun 2001 10:36:02 -0400
Received: from NS.CenSoft.COM ([208.219.23.2]:60934 "EHLO
	ns.centurysoftware.com") by vger.kernel.org with ESMTP
	id <S266094AbRF2Ofw>; Fri, 29 Jun 2001 10:35:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jordan Crouse <jordanc@Censoft.com>
Reply-To: jordanc@Censoft.com
Organization: The Microwindows Project
To: Holger Lubitz <h.lubitz@internet-factory.de>, linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Date: Fri, 29 Jun 2001 08:36:50 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0106281040000.10308-100000@localhost.localdomain> <9hfter$9e7$1@ncc1701.cistron.net> <3B3C85FD.B018746D@internet-factory.de>
In-Reply-To: <3B3C85FD.B018746D@internet-factory.de>
MIME-Version: 1.0
Message-Id: <01062908365000.25408@cosmic>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After all - how often does the average linux machine boot? Once a day at
> most. Mine usually run until the next kernel upgrade. But then again,
> I'm not a kernel hacker, so this is to be taken more as a users point of
> view.

Don't forget that embedded devices boot much more often than their desktop 
counterparts, and they are most often used by people who definitely fall into 
the non-linux savvy demographic (like my grandmother).

We use the Linux Progress Patch (http://lpp.FreeLords.org/) for our 
solutions.  Despite the size that it adds to the kernel (a 240 x 320 image is 
a pretty big linux_logo.h file), I feel that it makes the kernel booting 
procedure more painless for the average user (and the hackers can always use 
dmesg to find out what happened).

Jordan


