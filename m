Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbTGOMna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267884AbTGOMlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:41:50 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:56962 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S267686AbTGOMhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:37:05 -0400
Date: Tue, 15 Jul 2003 14:51:43 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XBox Gaming System subarchitecture.
Message-ID: <20030715125143.GC759@h55p111.delphi.afb.lu.se>
References: <20030714124933.GB20708@h55p111.delphi.afb.lu.se> <20030714135948.GA27930@suse.de> <20030714142152.GC20708@h55p111.delphi.afb.lu.se> <20030714142838.GA29413@suse.de> <20030714145429.GD20708@h55p111.delphi.afb.lu.se> <m1ptkcx8tp.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ptkcx8tp.fsf@frodo.biederman.org>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19cPHT-0003Zh-00*Tw5HiYjABZs*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 06:39:46AM -0600, Eric W. Biederman wrote:
> Have you tried running memtest86 on the box?  Except when you have more
> than 2GB memtest86 does not enable paging, so another code sequence can
> reproduce this bug memtest86 is likely to do it.

That was a very interesting idea... But I guess memtest86 wont be very fun
without a vga-bios.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
