Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbTCYRiE>; Tue, 25 Mar 2003 12:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263213AbTCYRiE>; Tue, 25 Mar 2003 12:38:04 -0500
Received: from franka.aracnet.com ([216.99.193.44]:62931 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263212AbTCYRiB>; Tue, 25 Mar 2003 12:38:01 -0500
Date: Tue, 25 Mar 2003 09:49:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: David van Hoose <davidvh@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.66 hanging after exiting KDE
Message-ID: <130800000.1048614548@[10.10.2.4]>
In-Reply-To: <3E809256.4040608@cox.net>
References: <3E809256.4040608@cox.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After loading up with 2.5.66 my system started to have odd behavior upon
> exiting KDE. It spontaneously rebooted once, but hangs the rest of the
> time. Not even SysRq works. I updated to the bk this morning, but the
> problem is still present. Not sure even where to start looking. Any ideas
> on where I should start to look?

Does this imply that 2.5.65 worked? Or you've upgraded from 2.4? I think
nmi_watchdog (or maybe kgdb) is the standard course in such cases ...

M.

