Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269218AbTGORdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269219AbTGORdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:33:20 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:33555
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S269218AbTGORdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:33:17 -0400
Date: Tue, 15 Jul 2003 10:48:07 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XBox Gaming System subarchitecture.
Message-ID: <20030715174807.GC904@matchmail.com>
Mail-Followup-To: Anders Gustafsson <andersg@0x63.nu>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
References: <20030714124933.GB20708@h55p111.delphi.afb.lu.se> <20030714135948.GA27930@suse.de> <20030714142152.GC20708@h55p111.delphi.afb.lu.se> <20030714142838.GA29413@suse.de> <20030714145429.GD20708@h55p111.delphi.afb.lu.se> <m1ptkcx8tp.fsf@frodo.biederman.org> <20030715125143.GC759@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715125143.GC759@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 02:51:43PM +0200, Anders Gustafsson wrote:
> On Tue, Jul 15, 2003 at 06:39:46AM -0600, Eric W. Biederman wrote:
> > Have you tried running memtest86 on the box?  Except when you have more
> > than 2GB memtest86 does not enable paging, so another code sequence can
> > reproduce this bug memtest86 is likely to do it.
> 
> That was a very interesting idea... But I guess memtest86 wont be very fun
> without a vga-bios.

It supports a serial console too.

Does Xbox have serial?
