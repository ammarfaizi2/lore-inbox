Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269661AbTHCTYo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 15:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270032AbTHCTYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 15:24:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:51909 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269661AbTHCTYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 15:24:42 -0400
Date: Sun, 3 Aug 2003 12:25:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shane Shrybman <shrybman@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 and mysql
Message-Id: <20030803122555.7cb01b08.akpm@osdl.org>
In-Reply-To: <1059922912.2282.15.camel@mars.goatskin.org>
References: <1059871132.2302.33.camel@mars.goatskin.org>
	<20030802180410.265dfe40.akpm@osdl.org>
	<1059875927.2966.32.camel@mars.goatskin.org>
	<20030802190859.3384ee08.akpm@osdl.org>
	<1059922912.2282.15.camel@mars.goatskin.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Shrybman <shrybman@sympatico.ca> wrote:
>
> I still haven't been able to make it appear in 2.6.0-test1-mm1, but once
>  when I rebooted from -test1-mm1 to -test2-mm3 the tables had problems
>  immediately

Sorry, test2-mm3 was a disaster.  I replaced it with test3-mm3-1, which
should be better.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm3/2.6.0-test2-mm3-1.bz2
