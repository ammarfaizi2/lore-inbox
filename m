Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUAPBUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 20:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUAPBU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 20:20:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:22478 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265210AbUAPBUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 20:20:19 -0500
Date: Thu, 15 Jan 2004 16:54:34 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, henrique.gobbi@cyclades.com,
       support@stallion.oz.au, R.E.Wolff@BitWizard.nl, paulus@samba.org,
       elfert@de.ibm.com, felfert@millenux.com, gerg@snapgear.com,
       kuba@mareimbrium.org
Subject: Re: [2/3]
Message-ID: <20040116005434.GH23253@kroah.com>
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth> <20040113113650.A2975@flint.arm.linux.org.uk> <20040113114948.B2975@flint.arm.linux.org.uk> <20040113171544.B7256@flint.arm.linux.org.uk> <20040113173352.D7256@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113173352.D7256@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 05:33:52PM +0000, Russell King wrote:
> ===== drivers/usb/serial/ftdi_sio.c 1.55 vs edited =====
> --- 1.55/drivers/usb/serial/ftdi_sio.c	Tue Oct 28 13:44:01 2003
> +++ edited/drivers/usb/serial/ftdi_sio.c	Tue Jan 13 14:16:51 2004

Yeah, this ended up here due to a bad merge a few kernel releases ago.
I have the fix for this driver in my queue of USB patches to send off to
Linus soon.

Sorry about this.

Nice job in fixing up all of the other drivers, that was a big effort.

greg k-h
