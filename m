Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWAFAB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWAFAB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWAFAB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:01:56 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:12714 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932290AbWAFABz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:01:55 -0500
Date: Thu, 5 Jan 2006 19:53:41 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Better diagnostics for broken configs
Message-ID: <20060106005341.GA12833@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org> <Pine.LNX.4.61.0601050844550.10161@yvahk01.tjqt.qr> <20060105161436.GA4426@ccure.user-mode-linux.org> <Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 10:59:58PM +0100, Jan Engelhardt wrote:
> config MODE_TT
>         bool "Tracing thread support"
>         default y
>         help
>         This option controls whether tracing thread support is compiled
>         into UML.  Normally, this should be set to Y.  If you intend to
>         use only skas mode (and the host has the skas patch applied to it),
>         then it is OK to say N here.
> 
> Then I unfortunately do not quite understand what this is for.

The help is a bit out of date, that's all.

				Jeff
