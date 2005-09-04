Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVIDV1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVIDV1V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 17:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVIDV1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 17:27:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751187AbVIDV1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 17:27:21 -0400
Date: Sun, 4 Sep 2005 14:25:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org
Subject: Re: Brand-new notebook useless with Linux...
Message-Id: <20050904142530.4b906fef.akpm@osdl.org>
In-Reply-To: <E1EBje3-0002GW-00@chiark.greenend.org.uk>
References: <200509031859_MC3-1-A720-F705@compuserve.com>
	<E1EBje3-0002GW-00@chiark.greenend.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
>
>  > SD/MMC
> 
>  Ditto.
> 

There are Secure Digital drivers in -mm.  I'm sure Pierre would like a
tester..

>  > Additionally, the system clock runs at 2x normal speed with PowerNow enabled.
> 
>  http://bugzilla.kernel.org/show_bug.cgi?id=3927

Holy cow.  There's nearly as much action there as #4851.
