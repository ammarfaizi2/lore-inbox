Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292992AbSBVUhO>; Fri, 22 Feb 2002 15:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292991AbSBVUhF>; Fri, 22 Feb 2002 15:37:05 -0500
Received: from mail.interware.hu ([195.70.32.130]:55680 "EHLO
	mail.interware.hu") by vger.kernel.org with ESMTP
	id <S292990AbSBVUhB>; Fri, 22 Feb 2002 15:37:01 -0500
Date: Fri, 22 Feb 2002 21:37:00 +0100 (CET)
From: endre@interware.hu
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Eepro100 driver.
In-Reply-To: <3C767359.44CD415E@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0202222133270.8602-100000@dusk.interware.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Feb 2002, Jeff Garzik wrote:

> > Would be a lot nicer to see someone spending the time pulling the
> > useful bits out of e100 and putting it into eepro100. e100 is ugly and
> > bloated for no reason.
>
> When it passes my review, it will not be.
> e100 + my desired changes == eepro100 + my desired changes

Will it be possible to use the vlan code in the kernel with e100? From
what I can see Intel has its own way of doing vlans and that seems
powerful but overcomplicated to me.

endre

