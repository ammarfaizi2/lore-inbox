Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbVAQU3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVAQU3G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVAQU3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:29:06 -0500
Received: from quechua.inka.de ([193.197.184.2]:28548 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262872AbVAQU2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:28:00 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
Date: Mon, 17 Jan 2005 21:28:26 +0100
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2005.01.17.20.28.25.408571@dungeon.inka.de>
References: <41EAE36F.35354DDF@users.sourceforge.net> <41EB3E7E.7070100@tmr.com> <41EBD4D4.882B94D@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005 15:11:18 +0000, Jari Ruusu wrote:
> Mainline folks are just too much in love with their backdoored device
> crypto implementations [1]. If you want strong device crypto in mainline
> kernel, maybe you should take a look at FreeBSD gbde.

what about dm-crypt? I lost track, whether it is fixed or not.
(Or rather: whether secure modes where added, and which modes
are considered secure).

also my key is 32 random bytes and not a hash.
will I have any issue? dictionary attacks will
not work with that.

Thanks for your help.

Regards, Andreas

