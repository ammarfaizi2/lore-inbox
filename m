Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313480AbSDGW2G>; Sun, 7 Apr 2002 18:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313482AbSDGW2F>; Sun, 7 Apr 2002 18:28:05 -0400
Received: from [195.39.17.254] ([195.39.17.254]:17802 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313480AbSDGW2C>;
	Sun, 7 Apr 2002 18:28:02 -0400
Date: Sun, 7 Apr 2002 14:42:46 +0000
From: Pavel Machek <pavel@suse.cz>
To: Itai Nahshon <nahshon@actcom.co.il>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andrew Morton <akpm@zip.com.au>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020407144246.C46@toy.ucw.cz>
In-Reply-To: <E16tTAF-0008F2-00@the-village.bc.nu> <200204052302.g35N2o516910@lmail.actcom.co.il> <20020405180735.E15540@redhat.com> <200204060007.g3607I525699@lmail.actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> I'm curios, how much work can you accomplish on your laptop
> without any disk access (but you still need to save files - keeping
> them in buffers until it's time to actually write them).

Debugging session (emacs/gcc/gdb) for half an hour with disks stopped is
easy to accomplish.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

