Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTHYVhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbTHYVhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:37:37 -0400
Received: from [62.241.33.80] ([62.241.33.80]:39941 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262257AbTHYVhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:37:33 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andre Tomt <andre@tomt.net>, marcelo@conectiva.com.br
Subject: Re: about [PATCH] Allow sysrq() via /proc/sys/kernel/magickey
Date: Mon, 25 Aug 2003 23:37:20 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <3F4A7F8F.1070602@tomt.net>
In-Reply-To: <3F4A7F8F.1070602@tomt.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308252336.47033.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 August 2003 23:28, Andre Tomt wrote:

Hi Andre,

> <http://linux.bkbits.net:8080/linux-2.4/cset@1.1114?nav=index.html|ChangeSe

> /proc/sysrq-trigger is also in recent 2.4 (it got added in 2.4.21-pre,
> see <http://linux.bkbits.net:8080/linux-2.4/cset@1.930.74.2>). this
> patch just duplicates functionality.
> root@testing-builder /proc # uname -a
> Linux testing-builder 2.4.22-rc2-s3 #2 Thu Aug 21 18:11:16 CEST 2003
> i686 GNU/Linux

hmm, I am very sorry and I must have been totally blind that I missed that one 
completely. Marcelo, please undo this patch.

ciao, Marc

