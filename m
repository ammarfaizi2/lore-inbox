Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270395AbUJUNsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270395AbUJUNsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUJUNrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:47:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9856 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267362AbUJUNo1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:44:27 -0400
Date: Thu, 21 Oct 2004 09:44:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: John Cherry <cherry@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.9 - 2004-10-20.21.30) - 11 New warnings (gcc 3.2.2)
In-Reply-To: <200410211240.i9LCeDk8015277@cherrypit.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0410210942230.11962@chaos.analogic.com>
References: <200410211240.i9LCeDk8015277@cherrypit.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004, John Cherry wrote:

> drivers/char/mem.c:213: warning: `remap_page_range' is deprecated
  (declared at include/linux/mm.h:767)

Hmmm. What does one use instead???  We still use mmap in drivers
or is that going to be removed too?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
