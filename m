Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262179AbSIZE1w>; Thu, 26 Sep 2002 00:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbSIZE1F>; Thu, 26 Sep 2002 00:27:05 -0400
Received: from packet.digeo.com ([12.110.80.53]:54488 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262179AbSIZE06>;
	Thu, 26 Sep 2002 00:26:58 -0400
Message-ID: <3D928DC8.96E23CAF@digeo.com>
Date: Wed, 25 Sep 2002 21:32:08 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/4] increase traffic on linux-kernel
References: <3D928864.23666D93@digeo.com> <3D928C8B.5020609@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 04:32:08.0572 (UTC) FILETIME=[ACAFDBC0:01C26515]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> ...
> Magic Sysrq should be enable-able without affecting any other parts of
> the kernel.

or move sysrq outside CONFIG_DEBUG_KERNEL?
