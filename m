Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWAUTxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWAUTxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 14:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWAUTxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 14:53:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37350 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751203AbWAUTxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 14:53:18 -0500
Subject: Re: CBD Compressed Block Device, New embedded block device
From: Arjan van de Ven <arjan@infradead.org>
To: Shaun Savage <savages@tvlinux.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <43D3467C.7010803@tvlinux.org>
References: <43D3467C.7010803@tvlinux.org>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 20:53:15 +0100
Message-Id: <1137873195.23974.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-22 at 00:46 -0800, Shaun Savage wrote:
> HI
> 
> Here is a patch for 2.6.14.5 of CBD
> CBD is a compressed block device that is designed to shrink the file 
> system size to 1/3 the original size.  CBD is a block device on a file 
> system so, it also allows for in-field upgrade of file system.  If 
> necessary is also allows for secure booting, with a GRUB patch.
> 
> Reply to email please.


could you convert it to use mutexes instead of semaphores? ;)

