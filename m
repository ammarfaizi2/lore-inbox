Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVBDMJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVBDMJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 07:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVBDMJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 07:09:57 -0500
Received: from palrel12.hp.com ([156.153.255.237]:61416 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261168AbVBDMJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 07:09:54 -0500
Date: Fri, 4 Feb 2005 13:02:41 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torben.mathiasen@hp.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Devices.txt, update with LANANA
Message-ID: <20050204120241.GB4132@linux2>
References: <200502021845.j12Ij99X030188@hera.kernel.org> <20050203175710.GA24656@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203175710.GA24656@kroah.com>
X-OS: Linux 2.6.5-7.111-default
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03 2005, Greg KH wrote:

<snip>

> Hm, this is just wrong.  As I recall, LANANA is in charge of the major
> numbers, but for the USB major, the USB developers have been assigning
> the USB minors.  This patch just made the file different from what is
> currently present in the kernel.
> 
> Should I just submit a patch to LANANA to update the USB minors for
> their copy so this doesn't happen again?
>

Yes please!. Since the devices file at lanana.org is the one being merged into
the one in the kernel tree, please send future updates to lanana and it'll go
in that way.

Thanks,
Torben
