Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263721AbTDTVzp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTDTVzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:55:45 -0400
Received: from [80.190.48.67] ([80.190.48.67]:29188 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263721AbTDTVzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:55:44 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Neil Schemenauer <nas@python.ca>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH][CFT] new IO scheduler for 2.4.20
Date: Mon, 21 Apr 2003 00:06:23 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030417172818.GA8848@glacier.arctrix.com> <20030417134103.4e69fc1b.akpm@digeo.com> <20030420182648.GA18120@glacier.arctrix.com>
In-Reply-To: <20030420182648.GA18120@glacier.arctrix.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304210006.23762.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 April 2003 20:26, Neil Schemenauer wrote:

Hi Neil,

> Okay, nas1 is the patch I orginally posted.  With nas2, I am counting
> requests instead of sectors.  The times below are for the find/cat
> command to complete while the dd command is running.
>     2.4.20  ????????? (I gave up after about 15 minutes)
>     -nas1   1m56.746s
>     -nas2   2m36.928s
> Here's the contest results:
what about i/o throughput, bonnie or such?

ciao, Marc


