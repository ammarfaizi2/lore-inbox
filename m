Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWB0WgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWB0WgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWB0WgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:36:22 -0500
Received: from smtp.enter.net ([216.193.128.24]:8712 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932470AbWB0WgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:36:14 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: "Peter Gordon" <codergeek42@gmail.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 27 Feb 2006 17:24:39 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <fa.deNPP6WI8uOxYJJt5IRsDHJHqNc@ifi.uio.no> <200602271647.48600.dhazelton@enter.net> <7e90c9180602271430m35051882jcc3e5b1608fb6be9@mail.gmail.com>
In-Reply-To: <7e90c9180602271430m35051882jcc3e5b1608fb6be9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271724.39562.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 17:30, Peter Gordon wrote:
> On 2/27/06, D. Hazelton <dhazelton@enter.net> wrote:
> > This value is also reported by the drive. I don't know about DVD drives,
> > but for CD drives it is a multiplier. 1x == 256K/sec transfer off the
> > disc [...]
>
> For CDs, 1x is actually 150 KByte/sec.

Well, I've been known to be wrong before, and this number was more based on 
the fact that I once measured a sustained transfer rate of 1M/sec on a 4x 
CDROM

> > I haven't had time to look into the DVD specification, but I'm guessing
> > that the DVD speed is about 3x what the CDROM speed is.
>
> According to WikiPedia, the DVD speed rating is almost 9 times that of
> CD speeds. I.e., 1x DVD is about 1.32 MByte/sec.

This was based on DVDx16 == CDx48 - I'm guessing someone is doing some monkey 
work if a DVD is 9x a CD and a 16x DVD can't hit that mystical 52x of my 
favorite CDRW drive in pure CD read mode.

>
> Just to make sure that we're all on the same page. :)
> ~~Peter

Thanks. Was just trying to dispel a few mis-statements and made some myself. 
I'm grateful for the update to my poor memory.

DRH
