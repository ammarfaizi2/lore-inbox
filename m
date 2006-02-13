Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWBMVt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWBMVt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWBMVt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:49:59 -0500
Received: from solarneutrino.net ([66.199.224.43]:56584 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932275AbWBMVt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:49:58 -0500
Date: Mon, 13 Feb 2006 16:49:57 -0500
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Random reboots
Message-ID: <20060213214956.GH16566@tau.solarneutrino.net>
References: <20060213210435.GC16566@tau.solarneutrino.net> <20060213211044.066CE5E401E@latitude.mynet.no-ip.org> <20060213212243.GE16566@tau.solarneutrino.net> <7c3341450602131332x2fcd7d8co@mail.gmail.com> <20060213213929.GG16566@tau.solarneutrino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060213213929.GG16566@tau.solarneutrino.net>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 04:39:29PM -0500, ryan wrote:
> It runs Debian Sarge for AMD64.  I have lots of other machines, but only
> this one gets the reboots.  None of the others have SCSI, and none are
> dual-CPU with memory on both nodes, just to name two obvious things
> different on this machine.

Thinking about this some more...  My home desktop also is a dual opteron
with memory on both nodes and SCSI, but it hasn't had any reboots.  The
machine with the reboot trouble uses RAID5+LVM, unlike my desktop.  Also
it's an NFS server, but I have another machine (single-cpu pentium 4, no
SCSI etc.) that's an NFS server without reboots.  But none of the other
machines have RAID or LVM.

It's maddening because half of the evidence points to hardware trouble
with this one machine, but the other half contradicts this.  It's
interesting to hear that other people are experiencing this, though.

-ryan
