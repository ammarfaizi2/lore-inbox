Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270132AbRHGHz7>; Tue, 7 Aug 2001 03:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270137AbRHGHzs>; Tue, 7 Aug 2001 03:55:48 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:23055 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S270136AbRHGHze>; Tue, 7 Aug 2001 03:55:34 -0400
Date: Tue, 7 Aug 2001 03:55:45 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
Message-ID: <20010807035545.D2399@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de> <Pine.LNX.4.33.0108062047310.17919-100000@kobayashi.soze.net> <15215.27296.959612.765065@localhost.efn.org> <200108070420.f774KXl04696@www.2ka.mipt.ru> <15215.39409.12204.662831@localhost.efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15215.39409.12204.662831@localhost.efn.org>; from stevev@efn.org on Tue, Aug 07, 2001 at 12:34:08AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 07/08/01 00:34 -0700 - Steve VanDevender:
> John Polyakov writes:
>  > Hmmm, if you have PHYSICAL access to the machine, you can simply reboot and type 
>  > "linux init=/bin/sh" and after it simply cat /etc/shadow and run John The Ripper....
>  > Am i wrong?
> 
> You can password-protect LILO to prevent others from giving it their own
> boot options.  Similarly you can password-protect single-user mode so
> either a deliberate shutdown-and-reboot to single-user mode, or an
> attempt to induce the machine to go into single-user mode, will prevent
> others from getting at the single-user root shell.

Hmm. Physical access. Hammer. Take drive.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
