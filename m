Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbTDYQDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 12:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTDYQDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 12:03:32 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9856 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263350AbTDYQDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 12:03:31 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304251618.h3PGINWP001520@81-2-122-30.bradfords.org.uk>
Subject: Re: versioned filesystems in linux (was Re: kernel support for
To: root@chaos.analogic.com
Date: Fri, 25 Apr 2003 17:18:23 +0100 (BST)
Cc: msell@ontimesupport.com (Matthew Sell),
       stewartsmith@mac.com (Stewart Smith),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.53.0304251131490.6515@chaos> from "Richard B. Johnson" at Apr 25, 2003 11:45:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You just modify your user-mode tools and your 'C' runtime library
> to make whatever atrocious versioning mechanism you want. You can
> even make all filenames upper case, just like VAX/VMS, and you can
> even make your shell DCL if you want. It's where the rules are
> enforced like (mapping everything to upper-case).
> 
> I can see it now, upon startup `init` execs:
> 
>    SYS$SYSTEM:LOGINOUT.EXE -
>    INPUT=SYS$SYSTEM:[etc]inittab -
>    OUTPUT=SYS$SYSTEM:[var.log]startup.log -
>    ERROR=SYS$SYSTEM:[dev]console -
>    UIC=[0,0] -
>    PRIV=(NOALL, TMPMBX, NETMBX, SETPRV)

Just wondering how difficult it would be to make a 9-track tape drive
from scratch, and connect it up to the parallel port...  Do you think
that old hard disk motors, from 5.25" MFM disks be powerful enough for
the 120IPS tape transport?

John.
