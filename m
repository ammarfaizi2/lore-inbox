Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVBWSrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVBWSrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 13:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVBWSrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 13:47:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:58857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261532AbVBWSq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 13:46:59 -0500
Date: Wed, 23 Feb 2005 10:47:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Telemaque Ndizihiwe <telendiz@eircom.net>
cc: duncan.sands@free.fr, linux-usb-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, trivial@rustcorp.com.au,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Replaces (2 * HZ) with DATA_TIMEOUT in /drivers/usb/atm/speedtch.c
In-Reply-To: <421CCE98.4090406@eircom.net>
Message-ID: <Pine.LNX.4.58.0502231046280.18997@ppc970.osdl.org>
References: <421CCE98.4090406@eircom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Feb 2005, Telemaque Ndizihiwe wrote:
>
> This Patch replaces "(2 * HZ)" with "DATA_TIMEOUT" which is defined as
>      #define DATA_TIMEOUT (2 * HZ)
> in /drivers/usb/atm/speedtch.c in kernel 2.6.10.

Your patches are white-space damaged due to linewrap (and possibly other 
issues, but the line-wrap was the obvious one).

Looks like you use Thunderbird, and I'm sure there's some way to just tell 
it to not mess with whitespace.

		Linus
