Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTDXRoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 13:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTDXRoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 13:44:08 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:20434 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S263752AbTDXRoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 13:44:07 -0400
Date: Thu, 24 Apr 2003 13:56:15 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Christoph Hellwig <hch@lst.de>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       viro@www.linux.org.uk
Subject: Re: 2.5.68-bk1 renames IDE disks, /dev/hda is directory
In-Reply-To: <20030424190431.A29056@lst.de>
Message-ID: <Pine.LNX.4.55.0304241355070.3189@marabou.research.att.com>
References: <Pine.LNX.4.55.0304211157430.14766@marabou.research.att.com>
 <20030421183935.A27811@lst.de> <Pine.LNX.4.55.0304241257520.2855@marabou.research.att.com>
 <20030424190431.A29056@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003, Christoph Hellwig wrote:

> On Thu, Apr 24, 2003 at 01:01:32PM -0400, Pavel Roskin wrote:
> > Somebody please apply this patch:
> >
> > http://hypermail.idiosynkrasia.net/linux-kernel/latestweek/0150.html
> >
> > It's still not in 2.5.68-bk5.  It's a major headache for everybody who
> > tries to use devfs with the current kernel.
>
> Sorry, I sent this to Linus two times but he hasn't applied it yet :P
>
> Linus, could you please apply this patch so all thos poor devfs
> users get their disks back?

I confirm that the new patch is working for me just as well as the old
one.

-- 
Regards,
Pavel Roskin
