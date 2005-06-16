Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVFPJTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFPJTY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 05:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVFPJTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 05:19:24 -0400
Received: from mail2.designassembly.de ([217.11.62.46]:20697 "EHLO
	mail2.designassembly.de") by vger.kernel.org with ESMTP
	id S261236AbVFPJTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 05:19:22 -0400
Message-ID: <42B14415.5060105@designassembly.de>
Date: Thu, 16 Jun 2005 11:19:17 +0200
From: Michael Heyse <mhk@designassembly.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050412)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reproducible 2.6.11.9 NFS Kernel Crashing Bug!
References: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin and others,

did you manage to resolve this problem? I'm also experiencing apparantly NFS-related crashes (kernel
hangs after a couple of seconds up to minutes, no syslog entries, nothing at all works any more)
using 2.6.11.10 and NFS V3 over TCP, standard r/wsizes, ext3 on a RAID5 array. Is this possibly
arch- or otherwise hardware-dependent? The NFS server works fine on my P4 on ASUS P4P800 board,
while it crashes my EPIA Board (VIA C3) using the same software configuration. Other network
applications run fine (as a workaround I'm using samba right now instead of nfs), so I don't think
my hardware is broken.

Thanks,
Michael
