Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131199AbRAUAWt>; Sat, 20 Jan 2001 19:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132753AbRAUAWk>; Sat, 20 Jan 2001 19:22:40 -0500
Received: from [216.151.155.116] ([216.151.155.116]:1796 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S131199AbRAUAW0>; Sat, 20 Jan 2001 19:22:26 -0500
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Daniel Stone <daniel@kabuki.eyep.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and ipmasq modules
In-Reply-To: <20010120144616.A16843@vitelus.com>
	<E14K7UY-0004hB-00@kabuki.eyep.net>
	<20010120153403.A17269@vitelus.com>
	<E14K83B-0004lQ-00@kabuki.eyep.net>
	<20010120160843.A17947@vitelus.com>
From: Doug McNaught <doug@wireboard.com>
Date: 20 Jan 2001 19:22:11 -0500
In-Reply-To: Aaron Lehmann's message of "Sat, 20 Jan 2001 16:08:43 -0800"
Message-ID: <m37l3p7o0c.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann <aaronl@vitelus.com> writes:

> On Sun, Jan 21, 2001 at 11:08:00AM +1100, Daniel Stone wrote:

> > "I'd rather stay with my friendly old pushbike than my car!"
> > So don't complain when you can't use cruise control.
> 
> ipfwadm used to support the modules. Why have the modules for ipfwadm
> been removed from the kernel source?

Umm, because the underlying infrastructure is completely different?

You're confusing 'ipfwadm' (a program that uses an old API that is
emulated by the new kernel) and the kernel ipfw code, which is gone,
gone, gone.

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
