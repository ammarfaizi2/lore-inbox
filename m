Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131100AbQKBAM5>; Wed, 1 Nov 2000 19:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130830AbQKBAMr>; Wed, 1 Nov 2000 19:12:47 -0500
Received: from hera.cwi.nl ([192.16.191.1]:5312 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130388AbQKBAM1>;
	Wed, 1 Nov 2000 19:12:27 -0500
Date: Thu, 2 Nov 2000 01:12:05 +0100
From: Andries Brouwer <aeb@veritas.com>
To: raptor <raptor@antifork.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug in hd geometry detect code?
Message-ID: <20001102011205.A11776@veritas.com>
In-Reply-To: <Pine.LNX.4.20.0011011436350.516-100000@hacaro.rewt.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.20.0011011436350.516-100000@hacaro.rewt.mil>; from raptor@antifork.org on Wed, Nov 01, 2000 at 02:37:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 02:37:00PM +0100, raptor wrote:

:  I've recently experienced a problem with hd geometry on Linux kernel
:  2.2.17. I've got 2 identical hard drives, set up as LBA on BIOS. BIOS sees
:  them both with geometry 1245/255/63, while Linux sees the second one as
:  19857/16/63. 

See the large disk howto, especially the section
"14.2 Nonproblem: Identical disks have different geometry?"

Andries

http://www.win.tue.nl/~aeb/linux/Large-Disk-14.html#ss14.2
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
