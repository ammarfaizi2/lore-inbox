Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbULFQ3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbULFQ3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbULFQ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:29:49 -0500
Received: from brown.brainfood.com ([146.82.138.61]:17057 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261561AbULFQ2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:28:47 -0500
Date: Mon, 6 Dec 2004 10:28:18 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ed L Cashin <ecashin@coraid.com>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
In-Reply-To: <87acsrqval.fsf@coraid.com>
Message-ID: <Pine.LNX.4.58.0412061027510.2173@gradall.private.brainfood.com>
References: <87acsrqval.fsf@coraid.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Ed L Cashin wrote:

> The included patch allows the Linux kernel to use the ATA over
> Ethernet (AoE) network protocol to communicate with any block device
> that handles the AoE protocol.  The Coraid EtherDrive (R) Storage
> Blade is the first hardware using AoE.
>
> AoE devices on the LAN are accessable as block devices and can be used
> with filesystems, Software RAID, LVM, etc.
>
> Like IP, AoE is an ethernet-level network protocol, registered with
> the IEEE.  Unlike IP, AoE is not routable.
>
> This patch is released under the terms of the GPL.
>
> (We also have an AoE driver for the 2.4 kernel that we plan to release
> soon.)

Is there a free server for this?
