Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278378AbRJMTck>; Sat, 13 Oct 2001 15:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278376AbRJMTcc>; Sat, 13 Oct 2001 15:32:32 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4868 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S278375AbRJMTcN>;
	Sat, 13 Oct 2001 15:32:13 -0400
Date: Mon, 8 Oct 2001 12:19:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Eric W. Biederman" <ebiederman@uswest.net>,
        Pavel Machek <pavel@Elf.ucw.cz>, Jeremy Elson <jelson@circlemud.org>,
        linux-kernel@vger.kernel.org
Subject: Re: linmodems (was Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices)
Message-ID: <20011008121911.A38@toy.ucw.cz>
In-Reply-To: <m1n132x4qg.fsf@frodo.biederman.org> <Pine.LNX.3.96.1011007213223.2882B-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.96.1011007213223.2882B-100000@mandrakesoft.mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Oct 07, 2001 at 09:37:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My best guess for a Linux winmodem solution for Linux is three pieces:
> The existing Lucent (and other) hardware work (by Pavel/Richard/Jamie/others?)
> Rogier Wolff's user space serial driver code, and
> A work called "modem" by a now-deceased scientist at SGI(IIRC).  Alan
> pointed me to the last piece.  'modem' handles up to 14.4k speed, and
> supports some error correcting protocols we all remember from the BBS
> days.
> 
> Just need someone to glue those pieces together... and you have a
> winmodem driver with the proper portions in userspace, and the proper
> portions in kernel space.

One of students here was/is working on the glue; it is non-trivial as
'modem' is obfuscated with coroutines.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

