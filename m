Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131878AbRC1Poc>; Wed, 28 Mar 2001 10:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131882AbRC1PoW>; Wed, 28 Mar 2001 10:44:22 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:1354 "EHLO tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP id <S131878AbRC1PoJ>; Wed, 28 Mar 2001 10:44:09 -0500
Date: Wed, 28 Mar 2001 09:43:24 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103281543.JAA43249@tomcat.admin.navo.hpc.mil>
To: rmk@arm.linux.org.uk, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: Disturbing news..
Cc: kaos@ocs.com.au, jesse@cats-chateau.net, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk>:
> On Wed, Mar 28, 2001 at 08:15:57AM -0600, Jesse Pollard wrote:
> > objcopy - copies object files. Object files are not marked executable...
> 
> objcopy copies executable files as well - check the kernel makefiles
> for examples.

At the time it's copying, the input doesn't need to be executable. That
appears to be a byproduct of a library link.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
