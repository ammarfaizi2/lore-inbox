Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTDENYi (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 08:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTDENYh (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 08:24:37 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:1482 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262197AbTDENYh (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 08:24:37 -0500
Subject: Re: some serious problems compiling 2.5.66-bk10
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304041820540.21137-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304041820540.21137-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1049549757.602.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 05 Apr 2003 15:35:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-05 at 01:23, Robert P. J. Day wrote:
>   i wanted to do another test with bk10 to see if i could
> track down my keyboard problems.  after having to deselect
> a couple graphics drivers as they caused the compile to 
> crash, i got a successful build of bzimage and modules.
> 
>   but after i typed "make modules_install", the final
> depmod generated some 2000 lines of unresolved symbols.
> should i have expected this?

Yes, since it seems you're not running the updates modutils from Rusty
Russell. Please, download latest modutils package from
ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules.

________________________________________________________________________
Linux Registered User #287198

