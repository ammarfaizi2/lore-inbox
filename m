Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030526AbWAGSJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbWAGSJo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030528AbWAGSJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:09:44 -0500
Received: from adicia.telenet-ops.be ([195.130.132.56]:35736 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1030526AbWAGSJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:09:43 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Subject: Re: [Linux-usb-users] USB floppy drive no longer works under 2.6.15-rc6
Date: Sat, 7 Jan 2006 19:09:49 +0100
User-Agent: KMail/1.9.1
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200512281251.03236.lkml@kcore.org> <20051228165157.GA13712@one-eyed-alien.net>
In-Reply-To: <20051228165157.GA13712@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601071909.50258.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 December 2005 17:51, Matthew Dharm wrote:
> Can you try without ehci_hcd loaded?  The device is only full-speed anyway,
> so there should be no performance loss (like floppy has any performance to
> lose...)

Sorry for the delay, I was on some hard-needed vacation :)

I've tried it with ehci_hcd unloaded, but it shows the same problems, only 
with the same style of messages.

Anything else to try?

Jan

-- 
The real purpose of books is to trap the mind into doing its own thinking.
		-- Christopher Morley
