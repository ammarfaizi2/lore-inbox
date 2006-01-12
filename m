Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWALRhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWALRhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWALRhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:37:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13959 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932302AbWALRhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:37:05 -0500
Date: Thu, 12 Jan 2006 09:36:24 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: mikpe@csd.uu.se, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, oliver@neukum.org,
       zaitcev@redhat.com
Subject: Re: need for packed attribute
Message-Id: <20060112093624.1c808c0e.zaitcev@redhat.com>
In-Reply-To: <20060112172617.GC9288@flint.arm.linux.org.uk>
References: <200601121227.k0CCRCB8016162@alkaid.it.uu.se>
	<20060112092006.6a9f4509.zaitcev@redhat.com>
	<20060112172617.GC9288@flint.arm.linux.org.uk>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 17:26:17 +0000, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Thu, Jan 12, 2006 at 09:20:06AM -0800, Pete Zaitcev wrote:

> > P.S. I am repeating myself as Katon, but I am yet to see why any of
> > this matters. Neither Russell nor Oliver ever presented a case where
> > an unpacked struct caused breakage in USB.
> 
> If you would like to refresh your memory (which is obviously faulty)
> you'll see that my involvement in this thread was merely to answer
> a simple question about structure sizes.

Isn't it exactly what I just wrote, and you quoted?

> It was not a bug report about USB breaking.  Therefore, I have no
> case to present.

The thread started with Oliver posting a patch. And later, he appealed
to your authority.

It seems that we both are saying that there's no problem, no case,
no nothing.

-- Pete
