Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272366AbTGaEJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 00:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272368AbTGaEJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 00:09:10 -0400
Received: from pop.gmx.de ([213.165.64.20]:34454 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272366AbTGaEJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 00:09:09 -0400
Message-Id: <5.2.1.1.2.20030731061140.01960870@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Thu, 31 Jul 2003 06:13:15 +0200
To: Andrew Morton <akpm@osdl.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.0-test2+ext3+dbench=Buffer I/O error
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030730150902.5281f72c.akpm@osdl.org>
References: <5.2.1.1.2.20030730163933.00b41b50@wen-online.de>
 <5.2.1.1.2.20030730163933.00b41b50@wen-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:09 PM 7/30/2003 -0700, Andrew Morton wrote:
>Mike Galbraith <efault@gmx.de> wrote:
>
> > I went back to test1, and it spat up a couple of "buffer
> > layer error" messages and associated traces.   Attempting to umount
> > afterward to run fsck left umount in D state.  See attachment.
>
>Well that's a worry.  Is it repeatable?

Not within 30 retry runs.  (elves and gremlins)

         -Mike 

