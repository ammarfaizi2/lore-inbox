Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289025AbSAFU0I>; Sun, 6 Jan 2002 15:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSAFUZ6>; Sun, 6 Jan 2002 15:25:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289025AbSAFUZo>; Sun, 6 Jan 2002 15:25:44 -0500
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Sun, 6 Jan 2002 20:36:00 +0000 (GMT)
Cc: akpm@zip.com.au (Andrew Morton), ivan@cyclades.com (Ivan Passos),
        linux-kernel@vger.kernel.org
In-Reply-To: <200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Jan 06, 2002 01:12:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NK1Q-0006Tc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Oh dear.  Why cannot devfs expand the minor part itself?
> 
> Do you mean why devfs can't do it, or do you mean why tty_name() can't
> do it? As I said, tty_name() used to do it, but there was some problem
> with that.

What was the problem ?
