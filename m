Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277249AbRJDWEg>; Thu, 4 Oct 2001 18:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277244AbRJDWEP>; Thu, 4 Oct 2001 18:04:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44048 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277249AbRJDWEE>; Thu, 4 Oct 2001 18:04:04 -0400
Subject: Re: CPU Temperature?
To: goemon@anime.net (Dan Hollis)
Date: Thu, 4 Oct 2001 23:09:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), harri@synopsys.COM,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110041442430.3919-100000@anime.net> from "Dan Hollis" at Oct 04, 2001 02:43:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pGg3-0004Qh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 4 Oct 2001, Alan Cox wrote:
> > > How can I access the CPU temperature, fan speed etc. from Linux?
> > > Or is this too hardware dependent to implement a common interface?
> > lm-sensors - it works well. Its shipped in some vendor trees
> 
> Whats the schedule to merge with mainline kernel? Right now we have two
> i2c trees -- the one in the kernel and the one in lm-sensors...

The -ac tree is in sync. Hch did the leg work for that
