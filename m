Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVEJUDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVEJUDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVEJUDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:03:38 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52118 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261770AbVEJUDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:03:33 -0400
Subject: Re: kernel (64bit) 4GB memory support
From: Lee Revell <rlrevell@joe-job.com>
To: rudi@asics.ws
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1115754522.4409.16.camel@cpu10>
References: <Pine.LNX.4.61.0412120934160.14734@montezuma.fsmlabs.com>
	 <1103027130.3650.73.camel@cpu0> <20041216074905.GA2417@c9x.org>
	 <1103213359.31392.71.camel@cpu0>
	 <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com>
	 <1103646195.3652.196.camel@cpu0>
	 <Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com>
	 <1103647158.3659.199.camel@cpu0>
	 <Pine.LNX.4.61.0412210955130.28648@montezuma.fsmlabs.com>
	 <1115654185.3296.658.camel@cpu10>
	 <20050509200721.GE2297@csclub.uwaterloo.ca>
	 <1115754522.4409.16.camel@cpu10>
Content-Type: text/plain
Date: Tue, 10 May 2005 16:03:31 -0400
Message-Id: <1115755412.14061.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 02:48 +0700, Rudolf Usselmann wrote:
> All my problems started when I "upgraded" to x86_64 ...
> 

And you are surprised by this?

I don't know why so many users buy an arch that didn't exist two years
ago and expect it to be 100% as reliable as 32 bit i386 which has been
around for 20 plus years.  I see tons of bug reports where people don't
bother to mention that "oh, btw this is a mixed 32/64 bit environment"
or whatever.

When you make the choice to live on the bleeding edge, these things will
happen.  If you don't like filling out bug reports stick with a 32 bit
machine ;-)

Lee

