Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267893AbUH2O1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbUH2O1O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUH2O1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:27:14 -0400
Received: from the-village.bc.nu ([81.2.110.252]:58496 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267893AbUH2O1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:27:13 -0400
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kenneth Lavrsen <kenneth@lavrsen.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <6.1.2.0.2.20040827171755.01c1f328@inet.uni2.dk>
References: <6.1.2.0.2.20040827171755.01c1f328@inet.uni2.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093785909.27933.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 14:25:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-27 at 17:26, Kenneth Lavrsen wrote:
> Greg decided that for fanatic and extremist reasons the 10000s - maybe 
> 100000s - of people that have invested in a Webcamera like a Logitech or 
> Philips can throw away their camera if they want to keep their Linux 
> systems up to date in future.

>From before the driver went in people have been pointing this out and
pointing out the decompress library belongs in user space. Nor did
anyone force the Nemosoft people to do this. If the base kernel version
is GPL then the version with the compressor added probably isnt GPL, but
Nemosoft wrote the whole driver so they can release a non-free whole
driver anyway

> And what about Nemosoft. Ideally it is pretty wrong of him to pull off the 
> driver from his site. That makes things even worse.

I would talk to Philips about doing it properly - in user space. I doubt
they are amused by Nemosoft pulling their stuff either. Unfortunately
its what happens when people rely on binary drivers and promises - they
get shafted.


