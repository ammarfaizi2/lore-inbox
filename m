Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbUBTQ5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 11:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbUBTQ5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 11:57:30 -0500
Received: from 81-223-104-78.krugerstrasse.Xdsl-line.inode.at ([81.223.104.78]:53430
	"EHLO mail.sk-tech.net") by vger.kernel.org with ESMTP
	id S261341AbUBTQ52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 11:57:28 -0500
Date: Fri, 20 Feb 2004 17:58:46 +0100 (CET)
From: Kianusch Sayah Karadji <kianusch@sk-tech.net>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-Scan Hangup ...
In-Reply-To: <Pine.LNX.4.58.0402200920270.621@merlin.sk-tech.net>
Message-ID: <Pine.LNX.4.58.0402201757260.29641@kryx.sk-tech.net>
References: <Pine.LNX.4.58.0402191426360.27436@kryx.sk-tech.net>
 <20040220002047.GB16267@kroah.com> <Pine.LNX.4.58.0402200920270.621@merlin.sk-tech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The very last thing I see when booting ist:
>
>    PCI: Probing PCI hardware (bus 0)
>
> That's it.  But it seems to be a BIOS Proble - I just found out that the
> Soekris-Home-Page states:
>
> [...]
>
>  The SC1100 has a bug where certain PCI config cycle conbinations can
>  cause the processor to lock up. comBIOS version 1.21 or newer reprogram
>  the chipset to fix the problem.
>
> [...]
>
> I'll try to upgrade my comBIOS this afternoon, and let you know if 2.6.x
> boot's fine or not.

The latest Bios seems to fix that problem.  Nativ kernel 2.6.3 boots
without any problem.

Thanx for Your help

Kianusch
