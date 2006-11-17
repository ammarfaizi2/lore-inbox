Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755519AbWKQHP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbWKQHP7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbWKQHP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:15:59 -0500
Received: from cantor.suse.de ([195.135.220.2]:53699 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1755519AbWKQHP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:15:58 -0500
To: Hasso Tepper <hasso@estpak.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sysctl syscall
References: <200611160003.02681.hasso@estpak.ee>
From: Andi Kleen <ak@suse.de>
Date: 17 Nov 2006 08:15:56 +0100
In-Reply-To: <200611160003.02681.hasso@estpak.ee>
Message-ID: <p734psyczmb.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hasso Tepper <hasso@estpak.ee> writes:
> 2.4 and 2.6 kernels and would work with capabilities (sys/capability.h)?
> Accessing `/proc/sys' directly isn't such alternative as it doesn't work 
> with capabilities.

What do you mean with "/proc/sys doesn't work with capabilities"?

-Andi

