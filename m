Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbUL1Xc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbUL1Xc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUL1Xc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:32:57 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:22687 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261155AbUL1Xc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:32:56 -0500
Subject: Re: stale POSIX flock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Garik E <kiragon@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <d4cc500a04122810186b7457eb@mail.gmail.com>
References: <d4cc500a04122810186b7457eb@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104272937.26109.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 22:28:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-12-28 at 18:18, Garik E wrote:
> I work with enterprise linux 3, IBM xSeries345, Pentium4 3000 x2,  2GB RAM

Older 2.4 has some threading problems with lock accounting. If you are
seeing this with Red Hat Enterprise Linux you should raise it with your
support person and/or file it in bugzilla.redhat.com/bugzilla.

Thanks

Alan

