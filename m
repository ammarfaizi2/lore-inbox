Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270414AbTGMVuX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 17:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270415AbTGMVuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 17:50:23 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:8586 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S270414AbTGMVuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 17:50:20 -0400
Date: Mon, 14 Jul 2003 00:05:00 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Message-ID: <20030713220500.GB7494@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 12:45:52AM +0200, Ingo Molnar wrote:
> 
> i'm pleased to announce the first public release of the "4GB/4GB VM split"
> patch, for the 2.5.74 Linux kernel:
> 
>    http://redhat.com/~mingo/4g-patches/4g-2.5.74-F8

FYI, VMware's vmmon/vmnet I maintain for 2.5.x kernels at 
http://platan.vc.cvut.cz/ftp/pub/vmware (currently 
.../vmware-any-any-update37.tar.gz) were updated to work correctly
with 4G/4G kernel configuration.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
