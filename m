Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284240AbRLPEBA>; Sat, 15 Dec 2001 23:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284242AbRLPEAv>; Sat, 15 Dec 2001 23:00:51 -0500
Received: from ns.suse.de ([213.95.15.193]:23059 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284240AbRLPEAg>;
	Sat, 15 Dec 2001 23:00:36 -0500
Date: Sun, 16 Dec 2001 05:00:31 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: David Gomez <davidge@jazzfree.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
In-Reply-To: <Pine.LNX.4.33.0112160421170.372-100000@fargo>
Message-ID: <Pine.LNX.4.33.0112160458500.15956-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2001, David Gomez wrote:

> I'm using kernel 2.4.17-rc1 and found what i think is a bug, maybe related
> to the loop device. This is the situation:

Can you repeat it with this applied ?
ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc1aa1/00_loop-deadlock-1

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

