Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSJPK3b>; Wed, 16 Oct 2002 06:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264882AbSJPK3b>; Wed, 16 Oct 2002 06:29:31 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:18180 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262380AbSJPK3b>;
	Wed, 16 Oct 2002 06:29:31 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-xfs@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre10-aa1: unresolved symbol in xfs.o 
In-reply-to: Your message of "Tue, 15 Oct 2002 18:19:08 +0200."
             <20021015161908.GC2546@dualathlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 Oct 2002 20:35:14 +1000
Message-ID: <30204.1034764514@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002 18:19:08 +0200, 
Andrea Arcangeli <andrea@suse.de> wrote:
>For some reason bleeding edge gcc from
>CVS generates a flood of symbol errors when I run depmod before
>rebooting, so I don't easily notice these missing exports anymore (I
>should run depmod post reboot to notice them). thanks,

modutils 2.4.17 has a change for recent binutils.

