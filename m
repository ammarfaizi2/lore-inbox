Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264823AbTFLLLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264824AbTFLLLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:11:53 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:62894 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S264823AbTFLLKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:10:44 -0400
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- strace lilo - freeze
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030612035442.29345778.akpm@digeo.com>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	 <1052513725.15923.45.camel@andyp.pdx.osdl.net>
	 <1055369326.1158.252.camel@andyp.pdx.osdl.net>
	 <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	 <1055377253.1222.8.camel@andyp.pdx.osdl.net>
	 <20030611172958.5e4d3500.akpm@digeo.com>
	 <1055414558.565.4.camel@chtephan.cs.pocnet.net>
	 <20030612035442.29345778.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1055417065.550.3.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 13:24:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2003-06-12 um 12.54 schrieb Andrew Morton:

> > BTW: I found out that now strace lilo freezes the machine...
> Works OK here.  Try `strace strace lilo' ;)

Since we are already talking about syncing...

The last thing "strace lilo" shows is:

fsync(5

-- 
Christophe Saout <christophe@saout.de>

