Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbUBUCUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 21:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUBUCUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 21:20:15 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:10721 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261509AbUBUCUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 21:20:00 -0500
Subject: Re: v2.6.3 blows up on compile
From: Christophe Saout <christophe@saout.de>
To: brown wrap <gramos@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040221013853.8034.qmail@web11507.mail.yahoo.com>
References: <20040221013853.8034.qmail@web11507.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1077330006.6585.0.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 03:20:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa, den 21.02.2004 schrieb brown wrap um 02:38:

> In trying to build a kernel, it always aborts in this
> area:
> 
>   CC      fs/proc/array.o
> /usr/src/linux-2.6.3/fs/proc/array.c: In function
> `proc_pid_stat':
> /usr/src/linux-2.6.3/fs/proc/array.c:398:
> Unrecognizable insn:
> (insn/i 721 1009 1003 (parallel[
> [...]

Your compiler seems to be broken.


