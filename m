Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272228AbTHIDGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 23:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272230AbTHIDGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 23:06:36 -0400
Received: from mail.suse.de ([213.95.15.193]:13319 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272228AbTHIDGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 23:06:32 -0400
Date: Sat, 9 Aug 2003 05:06:30 +0200 (CEST)
From: Andreas Gruenbacher <agruen@suse.de>
To: Marcelo Tossati <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.22-rc2 steal_locks and load_elf_binary cleanups
In-Reply-To: <1060389162.1795.33.camel@bree.suse.de>
Message-ID: <Pine.LNX.4.53.0308090459130.18879@Chaos.suse.de>
References: <1060389162.1795.33.camel@bree.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003, Andreas Gruenbacher wrote:

> Hello,
>
> please find attached some cleanups.

Please don't apply, see the thread:

  [PATCH] 2.4: Fix steal_locks race
