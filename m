Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282687AbRLQTfk>; Mon, 17 Dec 2001 14:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282691AbRLQTf3>; Mon, 17 Dec 2001 14:35:29 -0500
Received: from ns.suse.de ([213.95.15.193]:59154 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282687AbRLQTfR>;
	Mon, 17 Dec 2001 14:35:17 -0500
Date: Mon, 17 Dec 2001 20:35:17 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Eli Carter <eli.carter@inet.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-dj2
In-Reply-To: <3C1E43E7.7E8C525D@inet.com>
Message-ID: <Pine.LNX.4.33.0112172031480.28670-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Eli Carter wrote:

> > http://www.codemonkey.org.uk/patches/2.5/patch-2.5.1-dj2.diff.bz2
> Quick general question since I guess I missed it:  What is the 'charter'
> for the -dj branch?
> Are you accumulating the changes in 2.4 for Linus to merge into 2.5, or
> do you have another purpose?

Primarily its to keep 2.4 bits in sync, but at the same time
I'm going to try and keep it in a usable state for experimenting.
Carrying forward merges is no fun if I can't reboot the testboxes
for eg..
I'll also merge things expected to go to Marcelo/Linus to cut down on
merge time between Marcelo & Linus' patches.

When Linus is ready, the accumlated 2.4 bits will take priority
over anything else that happens to get picked up along the way.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

