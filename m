Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbTA1LLP>; Tue, 28 Jan 2003 06:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbTA1LLP>; Tue, 28 Jan 2003 06:11:15 -0500
Received: from [195.72.113.150] ([195.72.113.150]:60678 "EHLO
	schubert.rdns.com") by vger.kernel.org with ESMTP
	id <S265081AbTA1LLO>; Tue, 28 Jan 2003 06:11:14 -0500
Date: Tue, 28 Jan 2003 11:20:31 +0000 (GMT)
From: Robert Morris <rob@r-morris.co.uk>
X-X-Sender: rob@schubert.rdns.com
To: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
In-Reply-To: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2>
Message-ID: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

On Tue, 28 Jan 2003, Raphael Schmid wrote:

> It is my very understanding one can not have, conveniently it should be,
> a simple *bootscreen* under Linux. I don't *want* any simple picture, I
> want as complex a picture as it gets.
> 
> I realize these ideas may sound kind of alien to you, but they make sense.
> Windows, MacOS all have bootscreens. There really is no way why Linux
> shouldn't.

There is a very simple reason why Linux shouldn't have a "bootscreen" - 
its a lame idea. We have copied enough of the bad "features" of Windows et 
al into Linux already, IMHO.

FWIW, I usually remove the graphics from LILO/GRUB config as installed by 
default these days.

Most of the machines I maintain are very seldom rebooted, but if someone 
was to do a reboot, I would want them to be able to observe any errors or 
other abnormal output from the boot-up process. A "bootscreen" makes it 
more likely that such an error message would be more likely to go 
unnoticed - and, if they became commonplace, may eventually result in 
developers making the on-boot output less verbose/informative/etc, on the 
basis that it isn't likely to be seen in the first place!

The stuff you see on your screen when your Linux installation boots up 
weren't put there for no reason. Please lets leave them there!


Robert Morris
08707 458710
http://www.r-morris.co.uk/

