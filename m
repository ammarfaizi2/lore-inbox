Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUEMMHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUEMMHh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 08:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbUEMMHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 08:07:37 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:33802 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S264160AbUEMMHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 08:07:34 -0400
Date: Thu, 13 May 2004 13:07:08 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: Weird cold boot problems with Abit KT7 motherboard
Message-ID: <21588803.1084453628@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <Pine.LNX.4.58.0405121815120.2967@marabou.research.att.com>
References: <Pine.LNX.4.58.0405121815120.2967@marabou.research.att.com>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 12 May 2004 19:13 -0400 Pavel Roskin <proski@gnu.org> wrote:

> Hello!
> 
> I have noticed several anomalies with Abit KT7 motherboard.  They all
> happen after power on.  First reboot from Linux (using the reboot command
> or reset button) usually fixes all the problems.  Sometimes two or three
> resets are needed before the motherboard starts working properly.  In two
> cases (of about 20) the motherboard started working properly right after
> powering up.

Hmmm, I have one of these pieces of shit ... I have a boot issue with mine
on Windows too.  Graphics card doesn't initialise correctly on most boots.
Basically the rumours out there are that this mobo is marginal in an
undefined part of the agp spec to do with power levels, the reset line and
probabally the phase of the moon.  I have noticed that my machine will boot
more reliably when the ethernet card is not connected to the hub.  In my
case a long manual reset (pressy button) just after power on seem to fix
this from then on.  There is a site somewhere which shows you how to solder
some wire on which 'helps the +3v line' or something.

I hate this mobo.  But I'm too lazy to replace it.

-apw
