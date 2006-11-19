Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756496AbWKSH47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496AbWKSH47 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 02:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756499AbWKSH47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 02:56:59 -0500
Received: from cantor.suse.de ([195.135.220.2]:51923 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1756496AbWKSH46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 02:56:58 -0500
To: Dror Levin <spatz@psybear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: boot from efi on x86_64
References: <200611182107.03667.spatz@psybear.com>
From: Andi Kleen <ak@suse.de>
Date: 19 Nov 2006 08:56:52 +0100
In-Reply-To: <200611182107.03667.spatz@psybear.com>
Message-ID: <p73zmanc1iz.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dror Levin <spatz@psybear.com> writes:

> looking at the kernel source, after constant failures to boot linux on a core 
> 2 imac, has made me understand that only i386 and ia64 support efi booting, 
> but x86_64 does not.

x86-64 UEFI support is still being worked on.
Anyways, you should be able to boot Linux in the mean time using "boot camp"

-Andi
