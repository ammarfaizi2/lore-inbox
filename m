Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWAABdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWAABdp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 20:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWAABdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 20:33:45 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:6685 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S932155AbWAABdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 20:33:44 -0500
Date: Sun, 1 Jan 2006 02:33:43 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060101013343.GA19703@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch> <200512252304.32830.dtor_core@ameritech.net> <20051231235124.GA18506@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051231235124.GA18506@hansmi.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 12:51:24AM +0100, Michael Hanselmann wrote:
> +#define HID_QUIRK_POWERBOOK_NUMLOCK_ON		0x0002000

Aww, please ignore that one when looking at the patch. It's not used and
I'll resubmit the patch anyway with a full Signed-off-by & Co. once you
approve it.

Greets,
Michael
