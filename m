Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbULFRKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbULFRKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbULFRKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:10:36 -0500
Received: from brown.brainfood.com ([146.82.138.61]:58793 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261566AbULFRK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:10:26 -0500
Date: Mon, 6 Dec 2004 11:10:24 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
In-Reply-To: <87sm6jpe8o.fsf@coraid.com>
Message-ID: <Pine.LNX.4.58.0412061109230.2173@gradall.private.brainfood.com>
References: <87acsrqval.fsf@coraid.com> <Pine.LNX.4.58.0412061027510.2173@gradall.private.brainfood.com>
 <87sm6jpe8o.fsf@coraid.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Ed L Cashin wrote:

> Adam Heath <doogie@debian.org> writes:
>
> > On Mon, 6 Dec 2004, Ed L Cashin wrote:
> >
> >> The included patch allows the Linux kernel to use the ATA over
> >> Ethernet (AoE) network protocol to communicate with any block device
> >> that handles the AoE protocol.  The Coraid EtherDrive (R) Storage
> >> Blade is the first hardware using AoE.
> >>
> >> AoE devices on the LAN are accessable as block devices and can be used
> >> with filesystems, Software RAID, LVM, etc.
> >>
> >> Like IP, AoE is an ethernet-level network protocol, registered with
> >> the IEEE.  Unlike IP, AoE is not routable.
> >>
> >> This patch is released under the terms of the GPL.
> >>
> >> (We also have an AoE driver for the 2.4 kernel that we plan to release
> >> soon.)
> >
> > Is there a free server for this?
>
> Are you asking whether anybody has written software that allows a
> network host to export block storage using AoE?  Not yet, as far as I
> know.

Yup, that's what I was asking.  Bummer.
