Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268067AbUH1VvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268067AbUH1VvT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUH1VvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:51:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:39897 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268073AbUH1Vs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:48:29 -0400
Date: Sat, 28 Aug 2004 14:46:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 mount options doc
Message-Id: <20040828144630.13df93e0.akpm@osdl.org>
In-Reply-To: <20040828213014.GA2079@apps.cwi.nl>
References: <UTC200408271606.i7RG6tV27596.aeb@smtp.cwi.nl>
	<Pine.LNX.4.58.0408271104300.14196@ppc970.osdl.org>
	<20040828011959.GC16444@apps.cwi.nl>
	<Pine.LNX.4.58.0408271856071.14196@ppc970.osdl.org>
	<20040828213014.GA2079@apps.cwi.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <Andries.Brouwer@cwi.nl> wrote:
>
> Updated mount.8, and in the process added a few words to
>  Documentation/filesystems/ext2.txt too.

Linus's ext2.txt has recently been updated, so your patch generates 100%
rejects.

