Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267333AbTBUAry>; Thu, 20 Feb 2003 19:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbTBUArw>; Thu, 20 Feb 2003 19:47:52 -0500
Received: from rth.ninka.net ([216.101.162.244]:60583 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267333AbTBUAq1>;
	Thu, 20 Feb 2003 19:46:27 -0500
Subject: Re: IPsec in 2.5.62 broken?
From: "David S. Miller" <davem@redhat.com>
To: Ralf Spenneberg <ralf@spenneberg.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1045749548.1981.78.camel@kermit.spenneberg.de>
References: <1045739323.2172.63.camel@kermit.spenneberg.de> 
	<1045749548.1981.78.camel@kermit.spenneberg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Feb 2003 17:41:14 -0800
Message-Id: <1045791674.21545.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 05:59, Ralf Spenneberg wrote:
> Nevermind, I just figured out that IPv6 is mandatory to compile IPsec in
> Linux Kernel 2.5.62.

Not true, this problem is a bug and has been fixed in the
current 2.5.x sources.

