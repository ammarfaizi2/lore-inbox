Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbUDEVvg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUDEVtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:49:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:23517 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263315AbUDEVmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:42:42 -0400
Date: Mon, 5 Apr 2004 14:44:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] v4l: documentation update
Message-Id: <20040405144454.7718cd8f.akpm@osdl.org>
In-Reply-To: <20040405124103.GA30293@bytesex.org>
References: <20040405124103.GA30293@bytesex.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> wrote:
>
> I'd like also remove the Documentation/video4linux/bttv/Mod*.conf files,
> how to do that best?  Tell Linus to "bk remove" them?  Just mail a GNU
> patch which does?

'bk rm' is best.  Please wait until this patch is merged into Linus's tree
and then send us a reminder.
