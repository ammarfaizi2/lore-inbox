Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTKYKOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 05:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTKYKOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 05:14:20 -0500
Received: from [194.118.56.16] ([194.118.56.16]:39119 "EHLO mia.0xff.at")
	by vger.kernel.org with ESMTP id S262195AbTKYKOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 05:14:19 -0500
Subject: Re: LSI53C1030 (Fustion MPT) performance
From: Karl Pitrich <pit@0xff.at>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20031124115707.38eb0333.akpm@osdl.org>
References: <1069668564.2372.127.camel@warp.fabafsc.fabagl.fabasoft.com>
	 <20031124115707.38eb0333.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1069755265.2378.252.camel@warp.fabafsc.fabagl.fabasoft.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 25 Nov 2003 11:14:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-24 at 20:57, Andrew Morton wrote:
> Karl Pitrich <pit@0xff.at> wrote:
> >

<snip>

> > 
> 
> The 2.6 driver runs nicely in single-disk mode but has been reported to run
> like a dog in RAID mode.  I do not know if the 2.4 driver has the same problem.


well, i don't have a raid or mirror container configured.
the driver from 2.6.0-test9 (vanilla) runns nicely in fact, but is really, really slow,
my UDMA IDE machine is quite fast compared to the MPT.
(FYI: colleagues having the same machine running win2003 also tell me the disks are relatively slow)

further, i kindly heard from Dan Creswell <dan@dcrdev.demon.co.uk> that several 
people experience performance problems with this controller and that LSI is also 
aware of that and eager to fix this.


/ karl

