Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271336AbTHRIyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 04:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271341AbTHRIyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 04:54:41 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:22020 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S271336AbTHRIyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 04:54:40 -0400
Date: Mon, 18 Aug 2003 10:55:43 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Jeff Garzik <jgarzik@pobox.com>
cc: Jean Tourrilhes <jt@hpl.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5 IrDA] vlsi driver update
In-Reply-To: <3F3FD9C3.6000601@pobox.com>
Message-ID: <Pine.LNX.4.44.0308172221050.1469-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003, Jeff Garzik wrote:

> > 1) apply single big patch, basically replacing the code
> > 2) back out the existing driver and put in a new one resulting in the same 
> >    code as above
> > 3) do nothing, i.e. stay with vlsi_ir being worse and unsupported in 2.4 
> >    forever
> > 
> > Please advise!
> 
> 4) split up the patch, pretty please with sugar on it.

Ok, Thanks for the reply. As I don't want to suggest removing the driver 
from 2.6 at this point, I'll do the split-up when finding some time. As 
said, for 2.4 however this is not an option.

Given the time already wasted getting this into 2.5/2.6 this additional 
work forces me to consider 2.4 "don't care" for now - no problem. 
Jean, please tell me if you'd like some 2.4-backport to be put on your 
page so people can pull there.

Martin

