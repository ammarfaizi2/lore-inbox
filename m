Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269902AbTGSMQi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 08:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270036AbTGSMQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 08:16:38 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:20978 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S269902AbTGSMQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 08:16:36 -0400
Date: Sat, 19 Jul 2003 08:30:20 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Alasdair Kergon <agk@uk.sistina.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: LVM/device mapper support for 2.6.0-test1?
In-Reply-To: <20030718183027.A6328@uk.sistina.com>
Message-ID: <Pine.LNX.4.53.0307190828570.4719@localhost.localdomain>
References: <Pine.LNX.4.53.0307181254130.5747@localhost.localdomain>
 <20030718183027.A6328@uk.sistina.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003, Alasdair Kergon wrote:

> On Fri, Jul 18, 2003 at 12:55:02PM -0400, Robert P. J. Day wrote:
> >   any pointers to LVM[2] support for 2.6?  that last message
> > for LVM and device mapper referred only to 2.4.  thanks.
> 
> You should use the patches joe submitted to l-k recently together with
> the userspace library and tools in the tarballs on the ftp site.
> 
> Snapshots and pvmove are still being ported to 2.6.

i just built (successfully, i think :-) LVM2 under 2.6.0-test1-ac2,
and without testing it yet, i noticed that there is, in fact,
a "pvmove" command.  does that mean that all the pvmove functionality
is there now?  or what does it mean?

rday
