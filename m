Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267407AbTAQGGR>; Fri, 17 Jan 2003 01:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267408AbTAQGGR>; Fri, 17 Jan 2003 01:06:17 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:15121 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267407AbTAQGGQ>; Fri, 17 Jan 2003 01:06:16 -0500
Date: Fri, 17 Jan 2003 07:14:58 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Linux Geek <bourne@ToughGuy.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DUMB]: Is kernel oops always a kernel bug ???
Message-ID: <20030117061458.GA3450@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <3E279CC2.9040806@ToughGuy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E279CC2.9040806@ToughGuy.net>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linux Geek <bourne@ToughGuy.net>
Date: Fri, Jan 17, 2003 at 11:33:46AM +0530
> Hi all ,
> 
> If a kernel oops,  then is the problem always with the kernel ? Can't a 
> user proggie ( running as root ) do something insane and make the
> kernel oops ?
> 
That shouldn't happen - it's called DOS (Denial-Of-Service) if a user
program can make the kernel oops. Some of these probably still exist in
the linux kernel, nothing is perfect :-)

But another option exists: hardware failures. If your memory decides to
take a break, you will get an oops also.

Good luck,
Jurriaan
-- 
Holed up in your little room, we talk for hour on empty hour,
pacing up and down between the walls that we have built ourselves.
	New Model Army - Long Goodbye
GNU/Linux 2.5.58 SMP/ReiserFS 2x2752 bogomips load av: 0.16 0.61 0.61
