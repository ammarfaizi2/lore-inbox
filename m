Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbULGR3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbULGR3a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 12:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbULGR3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 12:29:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4744 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261861AbULGR2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 12:28:21 -0500
Date: Tue, 7 Dec 2004 11:28:12 -0600
From: Robin Holt <holt@sgi.com>
To: Andy <genanr@emsphone.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rereading disk geometry without reboot
Message-ID: <20041207172812.GD11423@lnx-holt.americas.sgi.com>
References: <20041206202356.GA5866@thumper2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206202356.GA5866@thumper2>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 02:23:56PM -0600, Andy wrote:
> I am using linux kernel 2.6.9 on a san.  I have file systems on
> non-partitioned disks.  I can resize the disk on the SAN, reboot and grow
> the XFS file system those disks.  What I would like to avoid rebooting or
> even unmounting the filesystem if possible.
> 
> Is there any way to get the kernel to re-read the disk geometry and change
> the information it holds without rebooting or reloading the module (which is
> as bad as a reboot in my case)?

Does anybody know if lvm can do this?

> 
> Thanks,
> 
> Andy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
