Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbUKSWfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUKSWfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUKSWeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:34:36 -0500
Received: from ozlabs.org ([203.10.76.45]:49031 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261667AbUKSWa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:30:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16798.29733.364848.474665@cargo.ozlabs.ibm.com>
Date: Sat, 20 Nov 2004 09:31:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, ak@suse.de, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: let x86_64 no longer define X86
In-Reply-To: <s5hoehuaxyg.wl@alsa2.suse.de>
References: <20041119005117.GM4943@stusta.de>
	<s5hoehuaxyg.wl@alsa2.suse.de>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai writes:

> If we do this for x86-64, shouldn't we do the same for ppc64 and sh64,
> too?  (only sparc64 seems not defining 32bit config.)

Both ppc32 and ppc64 define CONFIG_PPC already.

Paul.
