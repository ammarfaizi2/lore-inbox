Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271982AbRHVKux>; Wed, 22 Aug 2001 06:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271149AbRHVKun>; Wed, 22 Aug 2001 06:50:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5132 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271982AbRHVKu0>; Wed, 22 Aug 2001 06:50:26 -0400
Subject: Re: Oops when accessing /dev/fd0 (kernel 2.4.7 and devfsd 1.3.11)
To: steve@navaho.co.uk (Steve Hill)
Date: Wed, 22 Aug 2001 11:53:01 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        taylorcc@codecafe.com (Taylor Carpenter),
        rgooch@ras.ucalgary.ca (Richard Gooch), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108221146270.18880-100000@sorbus.navaho> from "Steve Hill" at Aug 22, 2001 11:48:02 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZVd7-0001KS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> there, but I have no problem with compiling it into the kernel - it
> doesn't seem to break, just says "no floppy controller present" on the
> floppy-less boxes.)

Timing dependant - sometimes you get no floppy controller, sometimes a crash
and sometimes moans about things still being active

