Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUEHGKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUEHGKH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 02:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUEHGKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 02:10:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:28846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264154AbUEHGKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 02:10:03 -0400
Date: Fri, 7 May 2004 23:09:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: rusty@rustcorp.com.au, bruceg@em.ca, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-Id: <20040507230915.447a92fa.akpm@osdl.org>
In-Reply-To: <200405072213.23167.rjwysocki@sisk.pl>
References: <20040505013135.7689e38d.akpm@osdl.org>
	<20040506195223.017cd7f6.akpm@osdl.org>
	<1083903398.7481.43.camel@bach>
	<200405072213.23167.rjwysocki@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
>
> On Friday 07 of May 2004 06:16, Rusty Russell wrote:
>  > On Fri, 2004-05-07 at 12:52, Andrew Morton wrote:
>  > > Bruce Guenter <bruceg@em.ca> wrote:
>  > > > On Wed, May 05, 2004 at 01:31:35AM -0700, Andrew Morton wrote:
>  > > > > Move-saved_command_line-to-init-mainc.patch
>  > > > >   Move saved_command_line to init/main.c
>  > > >
>  > > > This patch appears to be breaking serial console for me.  Reverting
>  > > > this patch with patch -R makes it work again.  I can't tell from the
>  > > > contents of the patch why it causes problems, but it does.  I'd be
>  > > > happy to provide any further details if required.
>  > >
>  > > Thanks for narrowing it down - I'd been meaning to look into the serial
>  > > console problem.
>  > >
>  > > Rusty, can you have a ponder please?
>  >
>  > Works for me: I use serial console.  Config please.
> 
>  As you wish,

Works for me too.  Can you share your kernel boot commandline with us?
