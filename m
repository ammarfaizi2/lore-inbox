Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbTAGVtO>; Tue, 7 Jan 2003 16:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267477AbTAGVtO>; Tue, 7 Jan 2003 16:49:14 -0500
Received: from freemail.agrinet.ch ([212.28.134.90]:12562 "EHLO
	freemail.agrinet.ch") by vger.kernel.org with ESMTP
	id <S267471AbTAGVtN>; Tue, 7 Jan 2003 16:49:13 -0500
Date: Tue, 7 Jan 2003 22:57:50 +0100
From: Andreas Tscharner <starfire@dplanet.ch>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: "Kaleb Pederson" <kibab@icehouse.net>
Subject: Re: windows=stable, linux=5 reboots/50 min
Message-Id: <20030107225750.0d379588.starfire@dplanet.ch>
In-Reply-To: <LDEEIFJOHNKAPECELHOAKEJFCCAA.kibab@icehouse.net>
References: <LDEEIFJOHNKAPECELHOAKEJFCCAA.kibab@icehouse.net>
Organization: No Such Penguin
X-Mailer: Sylpheed version 0.8.8claws25 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003 22:57:03 -0800
"Kaleb Pederson" <kibab@icehouse.net> wrote:

> After a recent hard drive crash, I re-installed Linux to a new hard
> drive. After about 2 weeks, my system now spontaneously reboots about
> once per 10 minutes (on avg.).  I'm assuming I messed up something in

[snip]
> NVidia TNT2 Utlra (considering the system sometimes crashes before I
> enter X and before the NVidia driver is loaded, my kernel has not been
> tainted at this point).

I still thinks it's the nvidia module. I've had the same problems with
kernels >2.4.18. Someone told me that it has to do something with the
coherency bug. I suggest trying 2.4.18...

Best regards
	Andreas
-- 
Andreas Tscharner                                  starfire@dplanet.ch
----------------------------------------------------------------------
"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the Universe trying
to produce bigger and better idiots. So far, the Universe is winning."
                                                          -- Rich Cook 
