Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281555AbRLDVGA>; Tue, 4 Dec 2001 16:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281410AbRLDVFo>; Tue, 4 Dec 2001 16:05:44 -0500
Received: from [206.98.161.198] ([206.98.161.198]:9231 "EHLO
	bart.learningpatterns.com") by vger.kernel.org with ESMTP
	id <S281180AbRLDVFV>; Tue, 4 Dec 2001 16:05:21 -0500
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
From: Edward Muller <emuller@learningpatterns.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16BM38-0003K1-00@the-village.bc.nu>
In-Reply-To: <E16BM38-0003K1-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 16:03:17 -0500
Message-Id: <1007499797.4520.11.camel@akira.learningpatterns.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-04 at 15:20, Alan Cox wrote:
> > > So anyone perfectly happy with an older distro that didn't
> > > ship python2-and-whatever-else gets screwed when they want to
> > > build a newer kernel. Nice.
> > 
> > That's been the case all along, sans python2. Newer kernels need newer
> > tools. That's always been the case.
> 
> Not during stable releases. In fact we've jumped through hoops several times
> to try and keep egcs built kernels working

Agreed. I spoke a little too broadly. But newer 'trees' (2.0 to 2.2 to
2.4 to 2.5) has always (IIRC) needed newer tools.

-- 
-------------------------------
Edward Muller
Director of IS

973-715-0230 (cell)
212-487-9064 x115 (NYC)

http://www.learningpatterns.com
-------------------------------

