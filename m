Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbUDQS4r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 14:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbUDQS4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 14:56:46 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:33152
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S264035AbUDQSzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 14:55:47 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Charles Shannon Hendrix <shannon@widomaker.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040417175538.GD2062@widomaker.com>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040416190126.GB408@widomaker.com>
	 <1082144608.2581.156.camel@lade.trondhjem.org>
	 <20040417000353.GA3750@widomaker.com>
	 <1082179726.3012.7.camel@lade.trondhjem.org>
	 <20040417175538.GD2062@widomaker.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082228137.2580.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 11:55:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 10:55, Charles Shannon Hendrix wrote:
> Usually, eliminating redundant writes in your application is a better
> optimization than relying on the OS to do it for you.

Fine. As long as you can convince all the other people sharing the same
page cache to do so too. We're not talking about single applications
here...

Cheers,
  Trond
