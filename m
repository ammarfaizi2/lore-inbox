Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTCOJQa>; Sat, 15 Mar 2003 04:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbTCOJQa>; Sat, 15 Mar 2003 04:16:30 -0500
Received: from [196.41.29.142] ([196.41.29.142]:29692 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S261353AbTCOJQ3>; Sat, 15 Mar 2003 04:16:29 -0500
Subject: Re: [PATCH] update filesystems config. menu
From: Martin Schlemmer <azarah@gentoo.org>
To: Mitch Adair <mitch@theneteffect.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Randy.Dunlap@mako.theneteffect.com,
       randy.dunlap@verizon.net, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <200303150920.h2F9KGm16328@mako.theneteffect.com>
References: <200303150920.h2F9KGm16328@mako.theneteffect.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047720287.3505.146.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 15 Mar 2003 11:24:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 11:20, Mitch Adair wrote:

> Anyway, I have seen instances where root got mounted ext2 instead of ext3
> (faulty initrd or whatever it was) - just wondered if the help should really
> push people to unreservedly say Y to ext2 if their root is really ext3...
> 

Should be safest for most people .. those that have experience will
anyhow know to only compile in ext3 support, and ext2 as module (if
you ever fsck floppy/whatever as ext2).


Regards,

-- 
Martin Schlemmer


