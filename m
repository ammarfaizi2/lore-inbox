Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbTGTPMa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 11:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267210AbTGTPMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 11:12:30 -0400
Received: from mcgroarty.net ([64.81.147.195]:8078 "EHLO pinkbits.internal")
	by vger.kernel.org with ESMTP id S267205AbTGTPM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 11:12:28 -0400
Date: Sun, 20 Jul 2003 10:27:27 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] HURD vs Linux/HURD
Message-ID: <20030720152727.GA23742@mcgroarty.net>
References: <20030720000716.GA1085@think> <20030720092239.E75410-100000@treason.nexuslabs.com> <20030720150905.A12659@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030720150905.A12659@infradead.org>
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 03:09:05PM +0100, Christoph Hellwig wrote:
> On Sun, Jul 20, 2003 at 09:23:19AM -0400, Charles E. Youse wrote:
> > My understanding is that theirs is a re-implementation of ext2, not a
> > port.
> 
> There's large part taken directly from Linux but the higher level
> parts are of course totally different.  Due to the GNU Obsfuc^H^H^H^H^HStyle
> it's not easy to diff, though..

So put both through the same code beautifier to normalize
formatting. Use ed to search/replace all non-C keywords with 'xxx' if
you think variables or function names are different well.
