Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWGLVJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWGLVJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWGLVJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:09:52 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:45210 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932256AbWGLVJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:09:52 -0400
Date: Wed, 12 Jul 2006 17:09:43 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 4/5] UML - Reenable SysRq support
Message-ID: <20060712210943.GA23195@ccure.user-mode-linux.org>
References: <200607121640.k6CGe6nP021236@ccure.user-mode-linux.org> <200607122056.01202.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607122056.01202.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 08:56:00PM +0200, Blaisorblade wrote:
> Please reject this patch, the setting for UML is just elsewhere, in 
> arch/um/Kconfig (and depends on MCONSOLE).

Whoops, right.

I swear I did a search on SYSRQ in menuconfig and the only thing that came
up was the lib/Kconfig.debug one.

I just checked, and it finds the arch/um one...

				Jeff
