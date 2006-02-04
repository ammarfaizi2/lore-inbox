Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWBDQrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWBDQrg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 11:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWBDQrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 11:47:35 -0500
Received: from dvhart.com ([64.146.134.43]:22166 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932519AbWBDQre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 11:47:34 -0500
Date: Sat, 4 Feb 2006 08:47:29 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       linux-fbdev-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: open bugzilla reports
Message-Id: <20060204084729.defc7c19.mbligh@mbligh.org>
In-Reply-To: <20060204095023.GA11140@flint.arm.linux.org.uk>
References: <20060203151150.3d9aa8b3.akpm@osdl.org>
	<20060204095023.GA11140@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > [Bug 5958] CF bluetooth card oopses machine when
> > 	http://bugzilla.kernel.org/show_bug.cgi?id=5958
> 
> This isn't a serial bug - it's a bluetooth ldisc bug.  I reported it
> to the bluetooth folk back when it first got raised by Pavel.  However,
> they seem to be completely disinterested in fixing it.
> 
> Unfortunately, there isn't a category for bt crap in bugzilla, otherwise
> I'd reassign it.  Please kick the bt folk.

Stick it under Drivers/Other if you want ...

M.
