Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbSJUNhG>; Mon, 21 Oct 2002 09:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSJUNhG>; Mon, 21 Oct 2002 09:37:06 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:16564 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261367AbSJUNhF>; Mon, 21 Oct 2002 09:37:05 -0400
Subject: Re: [PATCH] remove sys_security
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-security-module@wirex.com
In-Reply-To: <20021017201030.GA384@kroah.com>
References: <20021017195015.A4747@infradead.org>
	<20021017185352.GA32537@kroah.com> <20021017195838.A5325@infradead.org>
	<20021017190723.GB32537@kroah.com> <20021017210402.A7741@infradead.org> 
	<20021017201030.GA384@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 14:57:23 +0100
Message-Id: <1035208643.27309.109.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-17 at 21:10, Greg KH wrote:
> Ok, I think it's time for someone who actually cares about the security
> syscall to step up here to try to defend the existing interface.  I'm
> pretty sure Ericsson, HP, SELinux, and WireX all use this, so they need
> to be the ones defending it.

The existing interface is basically the one Linus asked for, although
perhaps with a little less thought on the structure side than it would
have benefitted

