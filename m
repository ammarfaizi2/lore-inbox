Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbRFZPH4>; Tue, 26 Jun 2001 11:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264973AbRFZPHr>; Tue, 26 Jun 2001 11:07:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30215 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264971AbRFZPHb>; Tue, 26 Jun 2001 11:07:31 -0400
Subject: Re: AMD thunderbird oops
To: adeucher@UU.NET (Alex Deucher)
Date: Tue, 26 Jun 2001 16:07:09 +0100 (BST)
Cc: joeja@mindspring.com, linux-kernel@vger.kernel.org
In-Reply-To: <3B389702.47C03532@uu.net> from "Alex Deucher" at Jun 26, 2001 10:06:58 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15EuQn-0003eT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get oopses too when I use kernels compiled for athlon on my redhat
> 7.1, athlon 850 system.  runs rock solid when I compile for i686.  I
> assumed the athlon optimizations in the kernel were broken, or gcc's
> athlon optimization was, as I seem to recall some discussion of this a
> while back on the LKML.

Most IWILL K266 people report this. Those who swapped them for other boards
mostly report the problem then going away. Yes it could be a bug we trigger
that by chance the IWILL boards show up more than others but I'm sceptical

Alan

