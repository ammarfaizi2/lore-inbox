Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTLCXHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTLCXHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:07:09 -0500
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:26524 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262280AbTLCXGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:06:40 -0500
Date: Thu, 4 Dec 2003 10:11:46 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031203231146.GA466@gnu.org>
References: <13d401c3b710$d6c17bf0$11ee4ca5@DIAMONDLX60> <20031130124916.GA5738@win.tue.nl> <20031203110605.GD1810@gnu.org> <20031203144254.GA7993@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031203144254.GA7993@win.tue.nl>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 03:42:54PM +0100, Andries Brouwer wrote:
> > > The point is just that the Linux kernel has no idea about these BIOS
> > > fantasies.
> > 
> > Can't you look inside BIOS memory, etc.?
> > Even call interrupts to query this stuff?
> 
> Of course. And the details differ from BIOS to BIOS.

I know.  But can't you figure it out for the 5 most popular BIOSes, or
whatever?  Seems like a job for the kernel.

Cheers,
Andrew

