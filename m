Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWFFHjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWFFHjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFFHjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:39:46 -0400
Received: from nyota.cc.fh-lippe.de ([193.16.112.78]:11663 "EHLO
	nyota.cc.fh-lippe.de") by vger.kernel.org with ESMTP
	id S932110AbWFFHjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:39:46 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Tue, 6 Jun 2006 09:39:43 +0200
From: Martin Hierling <martin.hierling@fh-luh.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.16.18 with general protection fault, perhaps nfsd
Message-ID: <20060606073943.GB10020@cc.fh-luh.de>
References: <20060531164707.GA19547@cc.fh-luh.de> <20060531204716.GL13682@fieldses.org> <20060601115313.GB4561@cc.fh-luh.de> <20060605175229.GL16064@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605175229.GL16064@fieldses.org>
X-URL: http://www.fh-luh.de/skim/netzwerk.html
User-Agent: Mutt/1.5.11
X-Skim-SendBy: pike.cc.fh-luh.de on Tue, 06 Jun 2006 09:39:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bruce, Hi List,


> > > > [4] Linux version 2.6.16.18-xen (root@defiant)
> > > Is there a xen patch applied as well?
> > sure. 3.0.2-2
> Well, this isn't a problem I can reproduce myself, and reading through
> the code I don't see how this could happen.  So, grasping at straws a
> bit, the only thing I can think to suspect is the xen patch.  I can't
> find any "3.0.2-2" patch anywhere, though; where can I find that code?

http://www.cl.cam.ac.uk/Research/SRG/netos/xen/downloads/xen-3.0.2-2-src.tgz

but as i wrote some days ago i found a memory error, so it did not
happen since then because i swapped the RAM.

thanks for your investigation.

 Martin
