Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbTH3Xga (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTH3Xg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:36:29 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:54283
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262300AbTH3XgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:36:01 -0400
Date: Sat, 30 Aug 2003 16:36:02 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Sebastian Reichelt <SebastianR@gmx.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA VT8231 router detection
Message-ID: <20030830233602.GC898@matchmail.com>
Mail-Followup-To: Sebastian Reichelt <SebastianR@gmx.de>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20030830151112.550df1a6.Sebastian@tigcc.ticalc.org> <3F50E0E6.2040907@pobox.com> <20030830201654.403f1421.SebastianR@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830201654.403f1421.SebastianR@gmx.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 08:16:54PM +0200, Sebastian Reichelt wrote:
> > Well, Mr. Newbie, your patch looks fine to me :)
> 
> Good :-)
> I did forget one thing, though: It's the file pci-irq.c in
> arch/i386/kernel. Well, there are only three files with this name in
> 2.4, but I just thought I'd mention it. ;-)

Then run patch from the root of the kernel tree next time, there will be no
confusion at all.
