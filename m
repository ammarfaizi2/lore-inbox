Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWCFTPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWCFTPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWCFTPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:15:24 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:49070 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751067AbWCFTPX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:15:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oivxpHmTXqIaH5krFjNOJ9d7lAgT0nFN/GfzShHU9qq5k0nKPb4pRpsSo4nptn6/2jWCx2A2ofHuDszSAxzs9eQkSOLf0Rw6dwhrIcUQKkOrud4iZVukSOxcK1QFhGhLAPInFoJEL2XkMinASmfaLZLW1ngDJ0wL+dud1QFzdww=
Message-ID: <41b516cb0603061115h4faf9115h407bd22ac070140@mail.gmail.com>
Date: Mon, 6 Mar 2006 11:15:22 -0800
From: "Chris Leech" <christopher.leech@intel.com>
Reply-To: chris.leech@gmail.com
To: gene.heskett@verizononline.net
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200603041705.41990.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060303214036.11908.10499.stgit@gitlost.site>
	 <Pine.LNX.4.61.0603041945520.29991@yvahk01.tjqt.qr>
	 <20060304.134144.122314124.davem@davemloft.net>
	 <200603041705.41990.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Does this buy the normal standard desktop user anything?
> >
> >Absolutely, it optimizes end-node performance.
>
> Is this quantifiable?, and does it only apply to Intel?

What we've been developing for is a device integrated into Intel's
Enterprise South Bridge 2 (ESB2), so it's a feature of Intel server
platforms.  But the networking changes are written so that you could
drop in a driver if similar functionality existed on other
architectures.

I'll look into what performance data I can share, I have to ask the
marketing folks.

- Chris
