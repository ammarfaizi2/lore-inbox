Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264082AbUFFToH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbUFFToH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 15:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUFFToH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 15:44:07 -0400
Received: from gprs214-14.eurotel.cz ([160.218.214.14]:33409 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264082AbUFFToF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 15:44:05 -0400
Date: Sun, 6 Jun 2004 21:43:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] Trivial, add missing newline at EOF in Documentation/networking/packet_mmap.txt
Message-ID: <20040606194354.GA10081@elf.ucw.cz>
References: <8A43C34093B3D5119F7D0004AC56F4BC082C7F88@difpst1a.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BC082C7F88@difpst1a.dif.dk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Missing newlines at the end of files make them less pleasing to work with
> for a number of tools that work on a line-by-line basis, and for source files
> it will cause gcc to emit a warning. So, I desided to add that missing
> newline to the few files in the kernel that are missing it.
> This patch makes no functional changes at all to the kernel.
> Patch is against 2.6.7-rc2
> 
> Here's the patch adding a newline to
> Documentation/networking/packet_mmap.txt

Perhaps you should strip headers/lkml signature of packet_mmap.txt? 
									Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
