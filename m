Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKOGpH>; Wed, 15 Nov 2000 01:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbQKOGor>; Wed, 15 Nov 2000 01:44:47 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:46858 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S129091AbQKOGoh>;
	Wed, 15 Nov 2000 01:44:37 -0500
Date: Wed, 15 Nov 2000 08:14:30 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: Rui Sousa <rsousa@grad.physics.sunysb.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Hard lockup using emu10k1-based sound card
In-Reply-To: <Pine.LNX.4.21.0011141216450.18636-100000@grad.physics.sunysb.edu>
Message-ID: <Pine.LNX.4.30.0011150801110.32433-100000@ccs.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000, Rui Sousa wrote:
> Which was the latest kernel you tried? A (easy to trigger) deadlock was
> fixed around 2.4.0-test...

It was around test7... I think. I remember seeing changes to emu10k1 in
the patch and I tried that version. It still crashed. I work almost
exclusively command line and saw no kernel error messages. The system
simply locked up and did not respond to SysRq etc.

I'll try test11-pre5 today.

-- Hans


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
