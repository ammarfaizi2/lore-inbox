Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261450AbSI2VGj>; Sun, 29 Sep 2002 17:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbSI2VGj>; Sun, 29 Sep 2002 17:06:39 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:11255 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261450AbSI2VGj>; Sun, 29 Sep 2002 17:06:39 -0400
Subject: Re: Kernel panic/exception dump support in 2.5?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209291640030.594-100000@coredump.sh0n.net>
References: <Pine.LNX.4.44.0209291640030.594-100000@coredump.sh0n.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 22:18:27 +0100
Message-Id: <1033334307.13795.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 21:42, Shawn Starr wrote:
> 
> It would really be nice if I could capture kernel exceptions/and oopsies
> on a file, or over a network connection. Redirecting console=lp0 to
> printer doesnt really let me paste dumps to LKML =)
> 
> Any solutions? Will we have a way to properly dump kernel failures
> (exceptions/oopies) somewhere?

The netdump patch can do this, including the actual kernel image

